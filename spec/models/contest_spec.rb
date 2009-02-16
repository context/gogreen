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
      @contest.teams << @team
      @pledge = create_pledge(:team => @team)
      @team.pledges << @pledge
      @pledge.user = create_user #:disabled => false
      @pledge.save
      @report = create_report(:pledge => @pledge, :start => @contest.start.utc.beginning_of_week )
      @pledge.reports << @report
      @report_action = create_report_action(:report => @report, :mode_of_transport => 'walk_bike', :position => 2 ) #:action_date => @report.start + 2.days)
      @report.report_actions << @report_action
      @contest.save
      @report.save
      @week = @report.start
    end

    it do
      impact = @contest.impact_for_week_starting(@week)
      impact.should == @pledge.impact_for_week_starting(@week).round_to(1)
    end

    it do
      impact = @contest.impact_for_week_starting(@week)
      impact.should == 87.4
    end

    it do
      @contest.week_impacts.should == Hash[ *@contest.weeks.map { |week_start| [ week_start, ( @contest.impact_for_week_starting(week_start) || 0.0 ).to_f.round_to(1) ] }.flatten ]
    end
  end
end
