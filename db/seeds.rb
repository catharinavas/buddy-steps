# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts 'clearing database'

Community.destroy_all #also destroys publications and community_users
User.destroy_all #also destroys goals, user_feelings, claps, messages and milestones
Category.destroy_all
Feeling.destroy_all
PublicationType.destroy_all

puts '---------------------------------------'

puts 'creating Communities'
parkinson = Community.create!(name: 'Parkinson')
stroke = Community.create!(name: 'Stroke')
depression = Community.create!(name: 'Depression')
amputation = Community.create!(name: 'Amputation')

puts 'creating Users'
40.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email:Faker::Internet.email,
    password: 'senha123'
  )

  user.communities = [Community.all.sample]
  user.save!
end

puts 'creating Goal Categories'
physical_category = Category.create!(name: 'Physical')
cognitive_category = Category.create!(name: 'Cognitive')
mental_health_category = Category.create!(name: 'Mental Health')
social_category = Category.create!(name: 'Social')
financial_category = Category.create!(name: 'Financial')

puts 'creating Goals, Messages and Milestones'
User.all.each do |user|
  rand(1..3).times do
    possible_budies = User.all.where.not(id: user)
    goal = Goal.new(
      title: Faker::Company.bs,
      description: Faker::Quote.famous_last_words,
      # start_date: DateTime.now,
      # deadline: (DateTime.now + rand(5..10).days),
      start_date: Date.new(2019,9,rand(1..30)),
      deadline: Date.new(2020,rand(1..6),rand(1..28)),
      category: Category.all.sample,
      complete: false,
      buddy: possible_budies.sample
    )
    goal.user = user
    goal.save!

    rand(20).times do
      Message.create!(goal: goal, user: user, content: Faker::Games::Overwatch.quote)
    end

    5.times do
      Milestone.create!(
        description: Faker::TvShows::RuPaul,
        deadline: Date.new(2019,rand(10..12),rand(1..30)),
        complete: [true, false, false].sample,
        goal: goal
      )
    end
  end
end

puts 'creating Feelings'
anxiety = Feeling.create!(name: 'Anxiety')
irritability = Feeling.create!(name: 'Irritability')
sleep_quality = Feeling.create!(name: 'Sleep Quality')
happinnes = Feeling.create!(name: 'Happinnes')

puts 'creating Feelings for the users'
User.all.each do |user|
  day = 20
  Feeling.all.each do |feeling|
    10.times do
      UserFeeling.create!(
        feeling_date: Date.new(2019,8,day),
        # feeling_date: DateTime.now,
        user: user,
        feeling: feeling,
        intensity: rand(1..5)
      )
      day += 1
    end
  end
end

puts 'creating PublicationTypes'
news = PublicationType.create!(name: 'News')
questions = PublicationType.create!(name: 'Questions')
celebrations = PublicationType.create!(name: 'Celebrations')
frustrations = PublicationType.create!(name: 'Frustrations')
pleasures = PublicationType.create!(name: 'Pleasures')

puts 'creating Publications and Claps in each community'
Community.all.each do |community|
  members = Community.users
  12.times do
    publication = Publication.create!(
      title: Faker::TvShows::TwinPeaks.quote,
      content: Faker::Lorem.paragraph(sentence_count: 4),
      publication_type: [news, questions, celebrations].sample,
      is_private: false,
      user: members.sample
    )
    author = publication.user

    rand(1..3) do
      possible_clappers = members.delete(author)
      clapper = possible_clappers.sample

      Clap.create!(publication: publication, user: clapper.sample)
      possible_clappers.delete!(clapper)
    end
  end
end

puts "creating Publications for users' diaries"
User.all.each do |user|
  5.times do
    publication = Publication.create!(
      title: Faker::TvShows::TwinPeaks.quote,
      content: Faker::Lorem.paragraph(sentence_count: 4),
      publication_type: [frustrations, pleasures].sample,
      is_private: false,
      user: user
    )
    rand(1..3) do
      Clap.create!(publication: publication, user: User.all.sample)
    end
  end
end

puts '---------------------------------------'
puts 'Seed is complete'
