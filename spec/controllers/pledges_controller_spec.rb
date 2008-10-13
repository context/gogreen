require File.dirname(__FILE__) + '/../spec_helper'

describe PledgesController do

  describe "create" do
    def act!
      pledge = new_pledge(:user => nil)
      post :create, :pledge => pledge.attributes.merge(:password => 'password', :password_confirmation => 'password', :user_attributes => new_user.attributes.merge(:password => 'password', :password_confirmation => 'password')), :contest_id => 1
    end
    it "logs in the new user" do
      act!
      controller.send(:logged_in?).should be_true
    end
  end
end
