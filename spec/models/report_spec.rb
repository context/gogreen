require File.dirname(__FILE__) + "/../spec_helper"

describe Report do
  before do
  end
  describe "validations" do
    before do
      @report = new_report
    end
    it "does not allow entries more than 2 weeks old" do
      @report.action_date = 4.weeks.ago 
      @report.valid?
      @report.should have_at_least(1).errors_on(:action_date)
    end
    it "allows resaving of older reports which have not changed" do
      @report.action_date = 4.weeks.ago 
      @report.stub!(:new_record?).and_return false
      @report.stub!(:changed?).and_return false
      @report.valid?
      @report.errors.should be_empty
    end
  end
end
