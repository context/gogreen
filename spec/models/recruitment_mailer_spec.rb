require File.dirname(__FILE__) + '/../spec_helper'

describe RecruitmentMailer do
  before do
    @contest = new_contest
    @body = "Join up dog!"
    @mail = RecruitmentMailer.create_tell_a_friend(:recipients => "dude@example.org", :body => @body, :contest => @contest, :host => "http://gogreen.local")
  end
  it "should contain an html part" do
    @mail.parts.first.body.should match(/#{@body}/)
  end
end
