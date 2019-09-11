# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

puts 'clearing database'

Message.destroy_all
Room.destroy_all
Community.destroy_all #also destroys publications and community_users
User.destroy_all #also destroys comments, goals, notifications, user_feelings, claps, messages and milestones
Goal.destroy_all
Category.destroy_all
Publication.destroy_all
PublicationType.destroy_all

puts '---------------------------------------'

puts 'creating Communities'
parkinson = Community.create!(name: 'Parkinson')
stroke = Community.create!(name: 'Stroke')
depression = Community.create!(name: 'Depression')
amputation = Community.create!(name: 'Amputation')

puts "Creating Lucas"
lucas = User.new(
    first_name: 'Lucas',
    last_name: 'Sandeville',
    email: 'lucas@nextstep.com',
    password: 'senha123',
    city: 'São Paulo'
  )
  url = "https://avatars1.githubusercontent.com/u/29074669?s=400&v=4"
  lucas.remote_photo_url = url

  lucas.communities << Community.all.sample
  lucas.save!

puts "Creating Daniela"
daniela = User.new(
    first_name: 'Daniela',
    last_name: 'Ichikawa',
    email: 'daniela@nextstep.com',
    password: 'senha123',
    city: 'São Paulo'
  )
  url = "https://avatars3.githubusercontent.com/u/52746846?s=400&v=4"
  daniela.remote_photo_url = url

  daniela.communities << Community.all.sample
  daniela.save!

puts "Creating Catharina"
catharina = User.new(
    first_name: 'Catharina',
    last_name: 'Vasconcelos',
    email: 'catharina@nextstep.com',
    password: 'senha123',
    city: 'São Paulo'
  )
  url = "https://avatars3.githubusercontent.com/u/17905364?s=400&v=4"
  catharina.remote_photo_url = url

  catharina.communities << Community.all.sample
  catharina.save!

puts "Creating Hugo"
hugo = User.new(
    first_name: 'Hugo',
    last_name: 'Branquinho',
    email: 'hugo@nextstep.com',
    password: 'senha123',
    city: 'São Paulo'
  )
  url = "https://avatars0.githubusercontent.com/u/52136198?s=460&v=4"
  hugo.remote_photo_url = url

  hugo.communities << Community.all.sample
  hugo.save!





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
other_category = Category.create!(name: 'Other')

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
      Message.create!(goal: goal, user: user, content: RobertoBarros.in_ingrish)
    end

    5.times do
      Milestone.create!(
        description: RobertoBarros.in_ingrish,
        deadline: (Date.today + rand(5..10).days),
        complete: [true, false, false].sample,
        goal: goal
      )
    end
  end
end


puts 'creating Feelings for general users'
User.all.each do |user|
  day = 1
  intensity = [3, 3, 3, 3]
  date = Date.today - 3.days
  2.times do
    UserFeeling.create!(
      feeling_date: (date + day.days),
      happiness: intensity[0],
      carefreeness: intensity[1],
      patience: intensity[2],
      sleep_quality: intensity[3],
      user: user,
    )
    intensity = intensity.map do |feel_int|
      new_feel_int = feel_int + [+1, +2, -1, -2].sample
      new_feel_int = 5 if new_feel_int > 5
      new_feel_int = 1 if new_feel_int < 1
      new_feel_int
    end

    day += 1
  end
end

puts 'creating Feelings for Lucas, Daniela, Catharina and Hugo '
[lucas, daniela, catharina, hugo].each do |user|
  day = 1
  puts "---creating feelings data for #{user.first_name}"
  intensity = [3, 3, 3, 3]
  date = Date.today - 51.days
  50.times do
    UserFeeling.create!(
      feeling_date: (date + day.days),
      happiness: intensity[0],
      carefreeness: intensity[1],
      patience: intensity[2],
      sleep_quality: intensity[3],
      user: user,
    )
    intensity = intensity.map do |feel_int|
      new_feel_int = feel_int + [+1, +2, -1, -2].sample
      new_feel_int = 5 if new_feel_int > 5
      new_feel_int = 1 if new_feel_int < 1
      new_feel_int
    end

    day += 1
  end
end

puts 'creating PublicationTypes'
news = PublicationType.create!(name: 'News')
question = PublicationType.create!(name: 'Question')
celebration = PublicationType.create!(name: 'Celebration')
frustration = PublicationType.create!(name: 'Frustration')
pleasure = PublicationType.create!(name: 'Pleasure')

puts 'creating Publications, Comments and Claps in each community'
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

      rand(1..3).times do
        members = community.users
        # possible_clappers = User.where.not(id: author)
        # clapper = possible_clappers.sample
        Clap.create!(publication: Publication.last, user: members.sample)
        # possible_clappers.delete!(clapper)
      end

      user1 = members.sample
      user2 = members.sample
      user3 = members.sample
      Comment.create!(publication: Publication.last, user: user1, content: "I totally see your point, but I still disagree.")
      Comment.create!(publication: Publication.last, user: user2, content: "Why?")
      Comment.create!(publication: Publication.last, user: user3, content: "sadjbajkdbjkdbwdawdw")
      Comment.create!(publication: Publication.last, user: user3, content: "Sorry, that was my cat walking on my keyboard:p")
      Comment.create!(publication: Publication.last, user: user1, content: "OP is ignoring that even though it ain't ideal, it does help many people to cope.")
    end
  end
end

puts "creating Publications for users' diaries"
User.all.each do |user|
  5.times do
    paragraphs =
      [
        Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s,
        Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s,
        Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s,
        Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s
      ]
    text = paragraphs.first(rand(2..4)).join("\n\n")

    publication = Publication.create!(
      title: Faker::TvShows::TwinPeaks.quote,
      content: text,
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
