require File.dirname(__FILE__) + '/../spec_helper'

describe Pledge do
  describe "associated user" do
    it "creates a user when given valid user attributes" do
      pledge = new_pledge(:user => nil, :user_attributes => new_user.attributes.merge(:password => 'password', :password_confirmation => 'password'))
      pledge.save
      pledge.user.should_not be_new_record
    end
  end
end
