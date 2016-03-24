module Homeland
  module Concerns
    module SoftDelete
      extend ActiveSupport::Concern

      included do
        alias_method :destroy!, :destroy

        default_scope -> { where(deleted_at: nil) }
      end

      def destroy
        run_callbacks(:destroy) do
          if persisted?
            t = Time.now.utc
            update_columns(deleted_at: t, updated_at: t)
          end

          @destroyed = true
        end
        freeze
      end

      def deleted?
        deleted_at.present?
      end
    end
  end
end
