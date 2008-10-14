require File.dirname(__FILE__) + '/../spec_helper'

describe Contest do
  describe "active finder" do
    it "finds active contests" do
      contest = create_contest :start => 1.day.ago, :end => 1.day.from_now
      Contest.active.should include(contest)
    end
    it "does not find inactive contests" do
      contest = create_contest :start => 2.weeks.ago, :end => 1.week.ago
      Contest.active.should_not include(contest)
    end
  end
end
