require 'spec_helper'

include Devise::TestHelpers

describe "Posts" do

  describe "GET /posts#index", :js => true do
    # self.use_transactional_fixtures = false
    let(:user) { FactoryGirl.create(:user) }
    before do
      login_user(user)
      visit posts_path
    end

    # TODO - make cucumber tests instead
    # can't get this to run in rails 4

    # describe "adding a post" do
    #   it "displays new post when valid" do
    #     fill_in 'post_text', :with => "A new post"
    #     click_button 'Post'
    #     page.should have_selector("div.posts div.post")
    #   end

    #   it "display error when invalid" do
    #     fill_in 'post_text', :with => ""
    #     click_button 'Post'
    #     page.should have_selector("form.post_form .error")
    #   end
    # end
    after do
      User.destroy_all
      Post.destroy_all
    end
  end

end
