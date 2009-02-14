require File.dirname(__FILE__) + "/../spec_helper"

describe Report do
  describe "unsaved" do
    describe "with action data" do
      before do
        @start_date = Time.now.utc.at_beginning_of_week
        @report = Report.new :start => @start_date, :actions_data => {'0' => {'mode_of_transport' => 'walk_bike'}, '1' => {'mode_of_transport' => 'walk_bike'}, '2' => {'mode_of_transport' => 'walk_bike'}, '3' => {'mode_of_transport' => 'walk_bike'}, '4' => {'mode_of_transport' => 'walk_bike'}}
      end
      it "should have 5 report actions" do
        @report.save
        @report.report_actions.length.should == 5
      end
      it "should set the action date for each action report" do
        @report.save
        @report.report_actions.each do |r|
          r.action_date.should == @start_date + r.position.days
        end
      end
    end
  end
  
  describe "pledge-report interactions" do
    before do
      @report = create_report
      @user = create_user
      @pledge = create_pledge :carpool_car_type => :truck, :carpool_distance => 5
      @pledge.user = @user
      @report.pledge = @pledge
      @pledge.reports << @report
      @pledge.save
    end
    
    describe "finding valid reports" do
      it "considers reports valid by default" do
        Report.valid.should include( @report )
      end
      it "excludes reports by disabled users" do
        
        @user.update_attribute :disabled, true  
        Report.valid.should_not include( @report )
      end
    end
    describe "tally action totals" do
      before do
        @report.report_actions << create_report_action( :position => 0, :mode_of_transport => 'carpool' )
        @report.report_actions << create_report_action( :position => 1, :mode_of_transport => 'carpool' )
        @report.report_actions << create_report_action( :position => 2, :mode_of_transport => 'public_transit' )
        @report.report_actions << create_report_action( :position => 3, :mode_of_transport => 'walk_bike' )
        @report.save
      end

      it "can count how often each action happened" do
        @report.tally_actions['carpool'].should == 2
        @report.tally_actions['walk_bike'].should == 1
      end
    end
    
    describe "calculate impacts" do
      before do
        @pledge.stub!(:pounds_used_by_driving).and_return(120)
        @pledge.stub!(:pounds_used_by_carpool).and_return(20)
        @report.report_actions << create_report_action( :position => 0, :mode_of_transport => 'carpool' )
      end
      it "knows how much carbon it reduced" do
        @report.impact.should == 100
      end
      it "saves the impact to an attribute" do
        @report.save
        @report.read_attribute(:impact).should == 100
      end
      it "changes if one of the actions has changed" do
        action = @report.report_actions.first
        action.mode_of_transport == 'none'
        @report.save
        @report.read_attribute(:impact).should == 100

      end
    end
  end
  
end
