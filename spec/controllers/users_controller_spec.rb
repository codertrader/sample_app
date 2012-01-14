require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end 

    it "should be successful" do
      get 'show', :id=>@user
      response.should be_success
    end

    it "should get the right user" do
      get "show", :id=>@user
      assigns(:user).should == @user # note: 'assigns' returns the controller variable
    end

    it "should have the right title" do
      get :show, :id=>@user
      response.should have_selector("title", :content => @user.name)
    end

    it "should have the right title" do
      get :show, :id=>@user
      response.should have_selector("h1", :content => @user.name)
    end

    it "should have a gravatar image" do
      get :show, :id=>@user
      response.should have_selector("img[alt='Gravatar']")
    end

  end

  describe "GET 'new'" do

    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end

  end

end
