require 'spec_helper'

describe "Layout links" do

  it "should have a Home page at'/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a Contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
  end

  it "should have an About page at '/about'" do
      get '/about'
      response.should have_selector('title', :content => "About")
  end

  it "should have a Help page at '/help'"do
      get '/help'
      response.should have_selector('title', :content => "Help")
  end

  describe "when not signed in" do
    it "should have a Sign in link"do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Sign in")
    end
  end

  describe "when signed in" do

    before(:each)do
      @user + Factory(:user)
      visit signin_path
      fill_i n :email,    :with => @user.email
      fill_in :password,  :with => @user.password
      click_button
    end

    it "should have a profile link"do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "profile")
    end
  end
end
