require 'test_helper'

class NodesTest < ActionDispatch::IntegrationTest
  setup do
    # 在 test/dummy/app/models/user.rb 里面 huacnlee@gmail.com 是管理员
    @current_user = create(:user, email: 'huacnlee@gmail.com')
    @node = create(:node)
  end

  test 'GET /homeland/nodes without admin' do
    create_list(:node, 3)
    get "/homeland/nodes"
    assert_response :success
    assert_select '.nodes' do
      assert_select '.node-item', Homeland::Node.count do
        assert_select 'a.edit', 0
        assert_select 'a.delete', 0
      end
    end
    assert_select 'a[href=?]', "/homeland/nodes/new", 0
  end

  test 'GET /homeland/nodes with admin' do
    sign_in @current_user
    create_list(:node, 3)
    get "/homeland/nodes"
    assert_response :success
    assert_select '.nodes' do
      assert_select '.node-item', Homeland::Node.count do
        assert_select 'a.edit'
        assert_select 'a.delete'
      end
    end
    assert_select 'a[href=?]', "/homeland/nodes/new", 1
  end

  test 'GET /homeland/nodes/new without admin' do
    user = create(:user)
    sign_in user
    get "/homeland/nodes/new"
    assert_access_denied
  end

  test 'GET /homeland/nodes/new with admin' do
    assert_equal true, @current_user.admin?
    sign_in @current_user
    get "/homeland/nodes/new"
    assert_response :success
    assert_select 'form.new_node' do
      assert_select 'input[name=?]', 'node[name]'
    end
    assert_select '.breadcrumb li.active', text: 'New Topic'
  end

  test 'POST /homeland/nodes without admin' do
    user = create(:user)
    sign_in user
    post "/homeland/nodes", params: { node: { name: '' }}
    assert_access_denied
  end

  test 'POST /homeland/nodes with admin' do
    params = {
      node: {
        name: 'New name by create',
        description: "New description by create",
        color: '#newcolor',
        sort: 1620
      }
    }
    sign_in @current_user
    assert_difference "Homeland::Node.count", +1 do
      post "/homeland/nodes", params: params
      node = Homeland::Node.last
      assert_response :redirect, "/homeland/c/#{node.id}"
      assert_equal 'Channel created success.', flash[:notice]
      assert_equal 'New name by create', node.name
      assert_equal 1620, node.sort
    end
  end

  test 'GET /homeland/nodes/:id/edit without admin' do
    user = create(:user)
    sign_in user
    get "/homeland/nodes/#{@node.id}/edit"
    assert_access_denied
  end

  test 'GET /homeland/nodes/:id/edit with admin' do
    assert_equal true, @current_user.admin?
    sign_in @current_user
    get "/homeland/nodes/#{@node.id}/edit"
    assert_response :success
    assert_select 'form.edit_node' do
      assert_select 'input[name=?]', 'node[name]'
    end
    assert_select '.breadcrumb li.active', text: 'Edit'
  end

  test 'PUT /homeland/nodes/:id without admin' do
    user = create(:user)
    sign_in user
    put "/homeland/nodes/#{@node.id}", params: { node: { name: '' }}
    assert_access_denied
  end

  test 'PUT /homeland/nodes/:id with admin' do
    params = {
      node: {
        name: 'New name',
        description: "New description",
        color: '#newcolor',
        sort: 1621
      }
    }
    sign_in @current_user
    put "/homeland/nodes/#{@node.id}", params: params
    assert_response :redirect, "/homeland/c/#{@node.id}"
    assert_equal 'Channel updated success.', flash[:notice]
    @node.reload
    assert_equal 'New name', @node.name
    assert_equal 'New description', @node.description
    assert_equal '#newcolor', @node.color
    assert_equal 1621, @node.sort
  end

  test 'DELETE /homeland/nodes/:id without admin' do
    node = create(:node)
    sign_in create(:user)
    delete "/homeland/nodes/#{node.id}"
    assert_access_denied
  end

  test 'DELETE /homeland/nodes/:id with admin' do
    node = create(:node)
    sign_in @current_user
    assert_difference "Homeland::Node.count", -1 do
      delete "/homeland/nodes/#{node.id}"
      assert_response :redirect, "/homeland/nodes"
      assert_equal 'Channel deleted success.', flash[:notice]
    end
  end
end
