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
    it "total impact is positive" do
      @pledge.reports << create_report
      @pledge.reports.first.report_actions << new_report_action(:mode_of_transport => 'walk_bike')
      @pledge.total_impact.should > 0.0
    end
    describe "carpool output" do
      it "works for small cars" do
        p = new_pledge(:carpool_distance => 5, :carpool_car_type => 'small', :carpool_additional_passengers => 2)
        tenths(p.pounds_used_by_carpool).should == 2.9
      end
      it "works for pickups" do
        p = new_pledge(:carpool_distance => 5, :carpool_car_type => 'truck', :carpool_additional_passengers => 2)
        tenths(p.pounds_used_by_carpool).should == 5.0
      end
      it "increases for pickups when you subtract people" do
        p = new_pledge(:carpool_distance => 5, :carpool_car_type => 'truck', :carpool_additional_passengers => 2)
        tenths(p.pounds_used_by_carpool).should > 2.5
      end
    end
    describe "when taking the bus" do
      it "is about a quarter of the distance in miles" do
        p = new_pledge(:distance_to_destination => 5)
        tenths(p.pounds_used_by_bus).should == 2.5
      end
    end
    describe "when taking the large car" do
      it "uses 1 gallon every 20 miles" do
        p = new_pledge(:distance_to_destination => 10, :car_type => :large )
        tenths(p.pounds_used_by_driving).should == tenths( Pledge::BASELINE_IMPACT_PER_GALLON )
      end
      it "uses 2 gallons every 40 miles" do
        p = new_pledge(:distance_to_destination => 20, :car_type => :large )
        tenths(p.pounds_used_by_driving).should == tenths( 2 * Pledge::BASELINE_IMPACT_PER_GALLON )
      end
    end
    describe "when staying home" do
      it "is no pounds" do
        p = new_pledge(:distance_to_destination => 20, :car_type => :large )
        tenths(p.pounds_used_by_none).should == 0
      end
    end
    describe "total pledged impact" do
      describe "baseline" do
        before do
          @pledge = new_pledge( :distance_to_destination => 10, :car_type => 'truck' )
        end
        it "is standard" do
          tenths( @pledge.pounds_used_by_driving ).should == 29.8
        end
      end
      describe "pounds saved by 2 days of walking" do
        before do
          @days_walking = 1
          @pledge = new_pledge :distance_to_destination => 10, :car_type => 'truck', :walk_bike => @days_walking
        end
        it "is the total output of yr car" do
          @pledge.weekly_commitment_impact.should == @pledge.pounds_used_by_driving * @days_walking
        end
      end
      describe "pounds saved by 2 days of carpooling" do
        before do
          @pledge = new_pledge :distance_to_destination => 10, :car_type => 'truck', :carpool_distance => 12, :carpool_car_type => 'truck', :carpool_additional_passengers => 1
        end
        it "is the difference between cars and routes" do
          tenths(@pledge.pounds_used_by_carpool).should == 17.9
        end
      end
    end
    describe "carpooling 1 day" do
      before do
        @pledge = new_pledge :distance_to_destination => 5, :car_type => 'small', :carpool_distance => 10, :carpool_car_type => 'small', :carpool_additional_passengers => 1
      end
      it "exactly offsets driving" do
        @pledge.pounds_used_by_driving.should == @pledge.pounds_used_by_carpool
      end
      it "" do
        @pledge.calculate_impact([['carpool', 1]]).should == 0.0
      end
    end
    describe "bus 2 days, carpool 1 day, walk/bike 2 days" do
      before do
        @pledge = new_pledge :distance_to_destination => 10, :car_type => 'truck', :carpool_distance => 8, :carpool_car_type => 'truck', :carpool_additional_passengers => 1, :carpool => 1, :public_transit => 2, :walk_bike => 2
      end
      it "exactly offsets driving" do
        tenths(@pledge.weekly_commitment_impact).should == 127.1
      end
    end
  end

  describe "disabled users" do
    it "should not appear in the enabled group" do
      Pledge.delete_all
      @pledge = create_pledge
      @pledge.user = create_user :disabled => true
      @pledge.save
      Pledge.enabled.should be_empty
    end
  end
  def tenths( num ) 
     (num * 10).round.to_f / 10
  end
end
