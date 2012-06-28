# coding: utf-8
require 'spec_helper'

describe "Navigation" do
  include Capybara::DSL

  it "should be a valid app" do
    ::Rails.application.should be_a(Dummy::Application)
  end

  before(:each) do
    sign_in_as
  end

  it "should open Topic list" do
    visit '/bbs/topics'
    page.has_selector?(".bbs_name")
    page.has_selector?(".topics")
  end

  it "should create a Topic" do
    visit '/bbs/topics/new'
    page.has_content?("新建帖子")
    fill_in "topic_node_id", :with => Node.first.id
    fill_in "topic_title", :with => "This is a topic"
    fill_in "topic_body", :with => "This is a topic body."
    click_button "保存"
    current_path.should == homeland.topic_path(Topic.last)
  end
end
