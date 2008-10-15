require File.dirname(__FILE__) + "/../spec_helper"

describe Report do
  describe "unsaved" do
    describe "with action data" do
      before do
        @start_date = Time.now.at_beginning_of_week
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

  describe "when editing" do
    describe "with action data" do
      before do
      end
    end
  end
end
