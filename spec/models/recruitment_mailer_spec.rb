require File.dirname(__FILE__) + '/../spec_helper'

describe RecruitmentMailer do
  before(:all) do
    ActionMailer::Base.default_url_options[:host] = 'gogreen.host'
  end

  before do
    @contest = new_contest(:id => 1)
    @body = "Join up dog!"
    @mail = RecruitmentMailer.create_tell_a_friend(:recipients => "dude@example.org", :body => @body, :contest => @contest)
    @text = @mail.parts.detect {|p| p.sub_type == 'plain' }
    @html = @mail.parts.detect {|p| p.sub_type == 'html' }
  end
  describe "the html part" do
    it "should contain the body" do
      @html.body.should match(/#{@body}/)
    end
    it "should have an absolute url to the pledge page" do
      @html.body.should match(/http:\/\/gogreen.host/)
    end
  end
end
