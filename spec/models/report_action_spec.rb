require File.dirname(__FILE__) + "/../spec_helper"

describe ReportAction do
  before do
  end
  describe "validations" do
    before do
      @report_action = new_report_action
    end
    it "does not allow entries more than 2 weeks old" do
      @report_action.action_date = 4.weeks.ago 
      @report_action.valid?
      @report_action.should have_at_least(1).errors_on(:action_date)
    end
    it "allows resaving of older report_actions which have not changed" do
      @report_action.action_date = 4.weeks.ago 
      @report_action.stub!(:new_record?).and_return false
      @report_action.stub!(:changed?).and_return false
      @report_action.valid?
      @report_action.errors.should be_empty
    end
  end
end
