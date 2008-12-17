require File.dirname(__FILE__) + '/../spec_helper'

describe Contest do
  describe "active finder" do
    it "finds active contests" do
      contest = create_contest :start => 1.day.ago, :end => 1.day.from_now
      Contest.active.should include(contest)
    end
    it "does not find inactive contests" do
      contest = create_contest :start => 3.weeks.ago, :end => 2.week.ago
      Contest.active.should_not include(contest)
    end
  end
  describe "impacts for week" do
    before do
      @contest = create_contest
      @team = create_team(:contest => @contest)
      @pledge = create_pledge(:team => @team)
      @report = create_report(:pledge => @pledge, :start => @contest.start.utc.beginning_of_week )
      @report_action = create_report_action(:report => @report, :mode_of_transport => 'walk_bike', :action_date => @report.start + 2.days)
      @week = @report.start
    end

    it do
      impact = @contest.impact_for_week_starting(@week)
      impact.should == @pledge.impact_for_week_starting(@week)
    end

    it do
      impact = @contest.impact_for_week_starting(@week)
      impact.round_to(4).should == 87.3693
    end

    it do
      @contest.week_impacts.should == Hash[ *@contest.weeks.map { |week_start| [ week_start, ( @contest.impact_for_week_starting(week_start) || 0.0 ).to_f.round_to(1) ] }.flatten ]
    end
  end
end
