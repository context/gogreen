require File.dirname(__FILE__) + '/../spec_helper'

describe ReportReminderMailer do
  include ActionController::UrlWriter
  before(:all) do
    ActionMailer::Base.default_url_options[:host] = 'gogreen.host'
  end

  before do
    @pledge = new_pledge
    @mail = ReportReminderMailer.create_reminder(@pledge)
    @text = @mail.parts.detect {|p| p.sub_type == 'plain' }
    @html = @mail.parts.detect {|p| p.sub_type == 'html' }
  end
  it "should be multipart" do
    @mail.should be_multipart
  end
  describe "the html part" do
    it "should render the contest email text" do
      @html.body.should match(/#{@pledge.contest.email_text}/)
    end
    it "should render the report url" do
      @html.body.should match(/#{new_pledge_report_url(@pledge)}/)
    end
    it "should render the report url with absolute path" do
      @html.body.should match(/gogreen.host/)
    end
    it "should render the opt-out url" do
      @html.body.should match(/#{@opt_out_url}/)
    end
  end
end
