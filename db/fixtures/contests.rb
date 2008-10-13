Contest.seed(:name) do |c|
  c.name = 'Spare The Air'
  c.permalink = 'spare-the-air'
  c.start = Time.mktime(2008, 11, 1)
  c.end = Time.mktime(2008, 12, 15)
  c.distance_question_text = 'how far do you travel to get to school?'
  c.tell_a_friend_default = <<-BODY
Join me in reducing your carbon footprint by pledging to bike, walk, carpool, or ride public transportation to school.
BODY
end
