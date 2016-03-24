require 'test_helper'

module Homeland
  module Markup
    class TestMarkup < Base
      class << self
        def render(raw)
          ['start', raw, 'end'].join('-')
        end
      end
    end
  end

  class MarkupTest < ActiveSupport::TestCase
    test 'Base markup' do
      assert_raise("Not implement render method.") {
        Homeland::Markup::Base.render('')
      }
    end

    test 'Extend a new markup' do
      raw = "Foo bar"
      Homeland.config.stub(:markup, :test_markup) do
        assert_equal 'start-Foo bar-end', Markup.render(raw)
      end
    end

    test '.render with :markdown' do
      raw = %(hello *world*)
      Homeland.config.stub(:markup, :markdown) do
        assert_equal "<p>hello <em>world</em></p>\n", Markup.render(raw)
      end
    end

    test '.render with :simple' do
      raw = <<~RAW
      Hello world <b>Foo</b>
      This is other line
      RAW
      out = <<~RAW
      <p>Hello world <b>Foo</b><br />This is other line</p>
      RAW
      Homeland.config.stub(:markup, :simple) do
        assert_equal out.strip, Markup.render(raw).gsub("\n", '')
      end
    end

    test '.render with :html' do
      raw = %(<span><i class='fa fa-trash'></i> Delete</span>)

      Homeland.config.stub(:markup, :html) do
        assert_equal raw, Markup.render(raw)
      end
    end
  end
end
