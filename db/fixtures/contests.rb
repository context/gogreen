Contest.seed(:name) do |c|
  c.name = 'Spare Our Planet'
  c.permalink = 'spare-our-planet'
  #c.start = Time.mktime(2008, 11, 1)
  #c.end = Time.mktime(2008, 12, 15)
  c.start = Time.mktime(2008, 10, 1)
  c.end = Time.mktime(2008, 11, 15)
  c.distance_question_text = 'How many miles do you travel to get to school?'
  c.image_data = File.open( "#{RAILS_ROOT}/public/images/gogreen/spare_our_planet.jpg" )
  c.tell_a_friend_default = <<-BODY
Join me in reducing your carbon footprint by pledging to bike, walk, carpool, or ride public transportation to school.
BODY
  c.email_text = <<EMAIL
Hey, your team at Go Green wants to know how you got to school last week.  Did you meet your pledge?
EMAIL
  c.intro_text = <<INTRO
Our objective is to promote personal behavior alternatives to carbon-intense consumption and lifestyle habits, and empower young people to play a significant role in developing climate change solutions. These initiatives will serve as case studies for a new, innovative and progressive public policy toward managing, slowing and ultimately reversing the effects of climate change.
INTRO
end
