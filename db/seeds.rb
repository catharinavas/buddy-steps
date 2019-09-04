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

puts "Creating Lucas"
user = User.new(
    first_name: 'Lucas',
    last_name: 'Sandeville',
    email: 'lucas@nextstep.com',
    password: 'senha123',
    city: 'São Paulo'
  )
  url = "https://avatars1.githubusercontent.com/u/29074669?s=400&v=4"
  user.remote_photo_url = url

  user.communities << Community.all.sample
  user.save!

puts "Creating Daniela"
user = User.new(
    first_name: 'Daniela',
    last_name: 'Ichikawa',
    email: 'daniela@nextstep.com',
    password: 'senha123',
    city: 'São Paulo'
  )
  url = "https://avatars3.githubusercontent.com/u/52746846?s=400&v=4"
  user.remote_photo_url = url

  user.communities << Community.all.sample
  user.save!

puts "Creating Catharina"
user = User.new(
    first_name: 'Catharina',
    last_name: 'Vasconcelos',
    email: 'catharina@nextstep.com',
    password: 'senha123',
    city: 'São Paulo'
  )
  url = "https://avatars3.githubusercontent.com/u/17905364?s=400&v=4"
  user.remote_photo_url = url

  user.communities << Community.all.sample
  user.save!

puts "Creating Hugo"
user = User.new(
    first_name: 'Hugo',
    last_name: 'Branquinho',
    email: 'hugo@nextstep.com',
    password: 'senha123',
    city: 'São Paulo'
  )
  url = "https://avatars0.githubusercontent.com/u/52136198?s=460&v=4"
  user.remote_photo_url = url

  user.communities << Community.all.sample
  user.save!





puts 'creating Users'
40.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email:Faker::Internet.email,
    password: 'senha123',
    city: Faker::Address.city
  )

  user.communities << Community.all.sample

  url = "https://source.unsplash.com/500x300/?person,face"
  user.remote_photo_url = url

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
    possible_budies = User.where.not(id: user)
    goal = Goal.new(
      title: Faker::Company.bs,
      description: Faker::Quote.famous_last_words,
      start_date: Date.today,
      deadline: (Date.today + rand(5..10).days),
      # start_date: Date.new(2019,9,rand(1..30)),
      # deadline: Date.new(2020,rand(1..6),rand(1..28)),
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
        description: Faker::TvShows::RuPaul.quote,
        deadline: (Date.today + rand(5..10).days),
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
  day = 1
  Feeling.all.each do |feeling|
    10.times do
      UserFeeling.create!(
        feeling_date: (Date.today + day.days),
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
question = PublicationType.create!(name: 'Question')
celebration = PublicationType.create!(name: 'Celebration')
frustration = PublicationType.create!(name: 'Frustration')
pleasure = PublicationType.create!(name: 'Pleasure')

puts 'creating Publications and Claps in each community'
Community.all.each do |community|
  # members = User.joins(:community_users).where(community_users:{community: community})
  members = community.users

  unless community.users == []
    paragraphs =
      [
        Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s,
        Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s,
        Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s,
        Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s
      ]
    text = paragraphs.first(rand(2..4)).join("\n\n")

    12.times do
      publication = Publication.create!(
        title: Faker::TvShows::TwinPeaks.quote,
        content: text,
        publication_type: [news, question, celebration].sample,
        is_private: false,
        community: community,
        user: members.sample
      )
      author = publication.user

      rand(1..3) do
        possible_clappers = User.where.not(id: author)
        clapper = possible_clappers.sample

        Clap.create!(publication: publication, user: clapper.sample)
        possible_clappers.delete!(clapper)
      end
    end
  end
end

puts "creating Publications for users' diaries"
User.all.each do |user|
  5.times do
    publication = Publication.create!(
      title: Faker::TvShows::TwinPeaks.quote,
      content: Faker::Lorem.paragraph(sentence_count: 4),
      publication_type: [frustration, pleasure].sample,
      is_private: true,
      user: user
    )
    rand(1..3) do
      Clap.create!(publication: publication, user: User.all.sample)
    end
  end
end

puts '---------------------------------------'
puts 'Seed is complete'
