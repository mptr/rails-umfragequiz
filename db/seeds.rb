# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

qTypes = ["TextQuestion", "NpsQuestion", "MultipleChoiceQuestion", "SingleChoiceQuestion", "NumberQuestion", "SliderQuestion", "ColorQuestion"]

(0..15).to_a.each do |i|
	u = User.create(username: Faker::Name.name, email: Faker::Internet.email)
	u.save
end

(0..50).to_a.each do |i|
	s = Survey.new(name: "#{Faker::Name.name}'s Survey")
	s.from_date = Date.today - rand(100)
	s.to_date = Date.today + rand(100) - rand(20)
	s.user = User.all.sample
	s.save
	qCount = rand(5) + 3
	(0..qCount).to_a.each do |j|
		q = Question.new(type: qTypes.sample, optional: rand(1), description: "Generated Question:" + Faker::Lorem.sentence)
		q.survey = s
		if(q.type == 'MultipleChoiceQuestion' || q.type == 'SingleChoiceQuestion')
			q.answer_options = Faker::Lorem.words(number: rand(5) + 3)
		end
		if(q.type == "NumberQuestion" || q.type == "SliderQuestion")
			q.from = rand(100)
			q.to = rand(100)
		end
		q.save
	end
end
