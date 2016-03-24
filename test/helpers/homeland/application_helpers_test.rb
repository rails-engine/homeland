require 'test_helper'

module Homeland
  class ApplicationHelpersTest < ::ActionView::TestCase
    test 'render_errors' do
      topic = Topic.new()
      topic.valid?
      html = render_errors(topic)
      assert_match %(<div class="alert alert-danger">), html
      assert_match %(Content can&#39;t be blank), html
      assert_match %(Node can&#39;t be blank), html
    end

    test 'timeago' do
      t = Time.now
      assert_equal %(<abbr class="timeago" title="#{t.getutc.iso8601}">#{t.to_s}</abbr>), timeago(t)
    end

    test 'node_tag' do
      node = Node.new(id: 12, name: "Foo", color: '#90CC11')
      html = node_tag(node)
      assert_equal %(<a class="node" href="#{homeland.node_topics_path(12)}"><i class="node-badge" style="background: #90CC11;"></i> <span class="name">Foo</span></a>), html
      assert_equal '', node_tag(nil)
    end

    test 'user_name_tag' do
      # nil
      assert_equal '', user_name_tag(nil)

      # Topic have no user
      topic = Topic.new(id: 100, title: "foo")
      assert_equal '', user_name_tag(topic)

      # Topic have user
      u = User.new(id: 2, email: "monster@gmail.com")
      topic.user = u
      assert_equal '<a class="user-name" href="/users/2">monster</a>', user_name_tag(topic)

      # Reply have no user
      reply = Reply.new(id: 22, body: '123123')
      assert_equal '', user_name_tag(reply)

      # Reply have user
      reply.user = u
      assert_equal '<a class="user-name" href="/users/2">monster</a>', user_name_tag(reply)
    end

    test 'user_avatar_tag' do
      default_image = %(<img class="avatar media-object" src="#{Homeland::ApplicationHelper::DEFAULT_AVATAR}" />)
      # nil param
      assert_equal default_image, user_avatar_tag(nil)

      # Reply have no user
      reply = Reply.new(id: 22, body: '123123')
      assert_equal default_image, user_avatar_tag(reply)

      # Reply have user, but user no avatar
      u = User.new(id: 2, email: "monster@gmail.com")
      reply.user = u

      u.stub(:avatar_url, nil) do
        html = user_avatar_tag(reply)
        assert_match default_image, html
        assert_match %(<a title="monster" class="user-avatar" href="/users/2">), html
      end

      html = user_avatar_tag(reply)
      assert_match %(<a title="monster" class="user-avatar" href="/users/2">), html
      alt = Digest::MD5.hexdigest(u.email)
      assert_match %(<img class="avatar media-object" src="#{u.avatar_url}" alt="#{alt}" />), html
    end
  end
end
