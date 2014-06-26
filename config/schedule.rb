every 1.day,:at => '10:00 am' do
	runner "Deal.expire"
  runner "Deal.publish"
end
