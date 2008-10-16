require File.dirname(__FILE__) + '/../spec_helper'

describe ReportsController do

  describe "new" do
    before do
      @pledge = create_pledge
    end

    describe "redirects to summary page", :shared => true do
      it "redirects" do
        act!
        response.should be_redirect
      end
      it "redirects to report follow-up page" do
        act!
        response.should redirect_to(team_path(@pledge.team))
      end
      it "sets a message in the flash that report has already been created" do
        act!
        flash[:notice].should_not be_empty
      end
    end

    describe "when no report exists", :shared => true do
      it "renders the new page" do
        act!
        response.should render_template('reports/new')
      end
    end

    describe "report for this week" do
      def act!
        get :new, :pledge_id => @pledge.to_param
      end
      describe "when a report already exists" do
        before do
          @pledge.reports.create :start => Time.now.utc.beginning_of_week
        end
        it_should_behave_like "redirects to summary page"
      end

      it_should_behave_like "when no report exists"
      
      it "should set start properly" do
        act!
        assigns[:report].start.should == Time.now.utc.beginning_of_week
      end
    end

    describe "report for last week" do
      def act!
        get :new, :pledge_id => @pledge.to_param, :week => 'previous'
      end
      describe "when a report already exists" do
        before do
          @pledge.reports.create :start => 1.week.ago.utc.beginning_of_week
        end
        it_should_behave_like "redirects to summary page"
      end

      it_should_behave_like "when no report exists"
      it "should set start properly" do
        act!
        assigns[:report].start.should == 1.week.ago.utc.beginning_of_week
      end
    end
  end

  describe "create" do
    before do
      @pledge = create_pledge
    end
    def act!
      post :create, :pledge_id => @pledge.to_param, :report => {:start => Time.now.utc.beginning_of_week}
    end
    describe "when a report for the week exists" do
      before do
        @pledge.reports.create :start => Time.now.utc.beginning_of_week
      end
      it "should not create a report" do
        lambda { act! }.should_not change(Report, :count)
      end
      it_should_behave_like "redirects to summary page"
    end
    it "should not create a report if we are outside the allowed reporting period"
  end
end
