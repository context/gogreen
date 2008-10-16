require File.dirname(__FILE__) + '/../spec_helper'

describe Pledge do
  describe "associated user" do
    it "creates a user when given valid user attributes" do
      pledge = new_pledge :user => nil
      pledge.user_attributes = new_user.attributes.merge(:password => 'password', :password_confirmation => 'password')
      pledge.save
      pledge.user.should_not be_new_record
    end
  end

  describe "when valid" do
    describe "number of days" do
      it "is no more than 5 for walk/bike" do
        pledge = new_pledge(:walk_bike => 6)
        pledge.should_not be_valid
      end
      it "is no more than 5 for public transit" do
        pledge = new_pledge(:public_transit => 6)
        pledge.should_not be_valid
      end
      it "is no more than 5 for carpool" do
        pledge = new_pledge(:carpool => 6)
        pledge.should_not be_valid
      end
      it "can be 5" do
        pledge = new_pledge(:carpool => 5)
        pledge.should be_valid
      end
      it "is no more than 5 for all modes" do
        pledge = new_pledge(:carpool => 4, :public_transit => 2)
        pledge.should_not be_valid
      end
      it "is no more than 5 for all modes" do
        pledge = new_pledge(:carpool => 4, :public_transit => 2)
        pledge.valid?
        pledge.should have(1).errors_on(:base)
      end
      it "is the only pledge for the user for the team" do
        user = create_user
        team = create_team
        first_pledge = create_pledge(:user => user, :team => team)
        second_pledge = new_pledge(:user => user, :team => team)
        second_pledge.should_not be_valid
      end
    end
  end

  describe "when calculating a score" do
    before do
      @pledge = create_pledge
    end
    it "total impact is correct" do
      @pledge.reports << create_report
      @pledge.reports.first.report_actions << new_report_action(:mode_of_transport => 'walk_bike')
      @pledge.total_impact.should > 0.0
    end
  end
end
