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
cancer = Community.create!(name: 'Cancer')
diabetes = Community.create!(name: 'Diabetes')

puts "Creating Lucas"
lucas = User.new(
    first_name: 'Lucas',
    last_name: 'Sandeville',
    email: 'lucas@buddysteps.com',
    password: 'senha123',
    city: 'São Paulo'
  )
  url = "https://avatars1.githubusercontent.com/u/29074669?s=400&v=4"
  lucas.remote_photo_url = url

  lucas.communities << Community.all.sample
  lucas.save!

puts "Creating Maria"
maria = User.new(
    first_name: 'Maria',
    last_name: 'Ichikawa',
    email: 'maria@buddysteps.com',
    password: 'senha123',
    city: 'São Paulo'
  )
  url = "https://avatars3.githubusercontent.com/u/52746846?s=400&v=4"
  maria.remote_photo_url = url

  maria.communities << Community.all.sample
  maria.save!

puts "Creating Catharina"
catharina = User.new(
    first_name: 'Catharina',
    last_name: 'Vasconcelos',
    email: 'catharina@buddysteps.com',
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
    email: 'hugo@buddysteps.com',
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
# User.all.each do |user|
#   day = 1
#   intensity = [3, 3, 3, 3]
#   date = Date.today - 3.days
#   2.times do
#     UserFeeling.create!(
#       feeling_date: (date + day.days),
#       happiness: intensity[0],
#       carefreeness: intensity[1],
#       patience: intensity[2],
#       sleep_quality: intensity[3],
#       user: user,
#     )
#     intensity = intensity.map do |feel_int|
#       new_feel_int = feel_int + [+1, +2, -1, -2].sample
#       new_feel_int = 5 if new_feel_int > 5
#       new_feel_int = 1 if new_feel_int < 1
#       new_feel_int
#     end

#     day += 1
#   end
# end

puts 'creating Feelings for Lucas, maria, Catharina and Hugo '
[lucas, maria, catharina, hugo].each do |user|
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
      new_feel_int = feel_int + [+1, +1, +1, +2, -1, -1, -1, -2].sample
      new_feel_int = 5 if new_feel_int > 5
      new_feel_int = 1 if new_feel_int < 1
      if rand() < 0.1
        new_feel = 0
      end
      new_feel_int
    end

    day += 1
  end
end

puts 'creating PublicationTypes'
news = PublicationType.create!(name: 'News')
question = PublicationType.create!(name: 'Question')
frustration = PublicationType.create!(name: 'Frustration')
pleasure = PublicationType.create!(name: 'Pleasure')



puts 'creating Publications, Comments and Claps in each community'


puts '--- creating them for the Parkinson community'
  # members = User.joins(:community_users).where(community_users:{community: community})
members = parkinson.users

publications = [
  { title: "Blood in your urine… what would you do? (Short survey!)",
    content: 'Let’s say that you go to see your doctor because you have blood in your urine. Your doctor tells you that he or she would like to do further tests to check for a rare cancer or other problem. In collaboration with one of our research partners, we’d like to ask how you would think about this situation.
      Usually the first step in the evaluation of blood in your urine is an imaging test to look at your urinary system.\n\nYou have two imaging options: a CT scan or an ultrasound. The CT scan provides detailed pictures of all the structures of the abdomen and pelvis, including the urinary tract, and uses radiation (x-rays) to make the pictures. The ultrasound images provide slightly less detail and are more focused on the urinary tract structures than other structures in the abdomen and pelvis and do not use radiation or x-rays.
      Ok, time for the questions!',
    publication_type: question,
    is_private: false,
    community: parkinson,
    user: members.sample
  },
  { title: 'What does everyone do to deal with constipation caused by Parkinson?',
    content: "I have Parkinson's and take norco for pain. OMG it is so tough to balance pain and not being constipated. I generally have found relief from Miralax. But, it doesn't always work. What does everyone else do?",
    publication_type: question,
    is_private: false,
    community: parkinson,
    user: members.sample,
  },
  { title: "Personality Change after DBS Surgery",
    content: "My husband was diagnosed with PD in 2013. He was an excellent candidate for DBS surgery. The surgery was a complete success with helping to control the tremors involved with PD. Since the surgery it is like I am married to a completely different person. He is not the jovial, loving, entertaining, motivated man I married.
      In our local PD caregiver-only support group meetings, I have heard about this. Can I get counseling -- together and for myself? Can I speak with the neurologist about this?
      Has anyone else encountered this?",
    publication_type: question,
    is_private: false,
    community: parkinson,
    user: members.sample,
  },
  { title: "Your mystery diagnosis may cause more than physical problems",
    content: "I am just realizing that what I thought was craziness in my early 20s was really due to Hashi's. There was no explanation for the weird feelings I was having, the doctors didn't know what to do with me, so they threw me to the psychiatrists, who filled me with crazy meds.
      I mentioned this in another thread, but those early years with Hashi's were a literal nightmare, severe panic attacks to the point of agoraphobia and feeling bizarre and out of control. The medical doc knew I had a low thyroid but I don't think they knew much about Hashi's then, so I lost so many years...
      Don't underestimate what this disease, and other autoimmune diseases, can do to your body and your life.",
    publication_type: news,
    is_private: false,
    community: parkinson,
    user: members.sample,
  },
  { title: "Need food advice for mom",
    content: "Mom has Parkinson's. She will eat healthy balanced meals and does not feel satisfied. Gets hungry soon after eating. Suggestions?",
    publication_type: question,
    is_private: false,
    community: parkinson,
    user: members.sample,
  },
  { title: "Supplements we use to Try to Slow Parkinson's Progression (and other neurodegenerative disorders)",
    content: "On several threads people wanted to know what supplements we are using to try to slow Parkinson's progression, so I'm posting this separately and will link to it from each of those places.
      Supplements discussed in this post: Ubiquinol, N-Acetyl-L Cysteine (NAC), EGCg (green tea extract), Longvida Curcumin
      That is a list of the most important supplements we are using to try to slow PD progression, along with our reasons for believing that they might be helpful in that regard. I'm not recommending these and I'm not saying that they will work for you. I'm just sharing what we have decided to do and why. As always, consult your physician when starting any new kind of treatment. Your doctor has direct experience with your body, knows your present medications, allergies, drug interactions, dietary restrictions, etc. This is not medical advice.
      Since these supplements are being taken mainly to slow progression, the main evidence that they are working would be if, over the years, progression seems slower than it was before taking them. There could be some immediate improvement as well, but mainly these are aimed at slowing disease progression.
      So if you happen to try any of these, don't expect immediate improvements in symptoms. It is entirely possible that you will see some direct symptomatic benefits, but that's not the main reason we are taking them. Rather, these are taken as a gamble that they will pay off in the long run by slowing the progression of the disease. It's impossible to prove that this will occur, but I've provided some research articles that seem to me (and I have no medical background) to support the likelihood that they might slow PD progression.
      I have made a rough estimate of how my own partner is doing, and according to that back-of-the-envelope calculation, she is doing better than about 72 percent of patients who are 11.5 years from diagnosis (she was diagnosed in 2006). Despite that, she gets a little worse every year; so I can't say we are pleased with the results, but we do sincerely believe that things would be worse if we had not taken these measures.
      We have refined what we are doing over the years, so we might be in even better shape now if we had been doing what we are now doing from the start. One big regret is that we started with ubiquinone instead of ubiquinol. We used the former, which is arguably not useful, for years before switching to ubiquinol. That might have cost us some neurons that might otherwise have been saved. But who knows? Read the linked studies and judge for yourself.
      Note that the links below are for reference only. You might find the same products for less at different websites, so please shop around to find the best price.
      Anyway, obviously there are no guarantees - especially given that everyone's PD is different in one way or another - but what is presented below are the main items that we are using, and why we decided to take them. YMMV.
      Speaking generally, we are using these supplements in the hope that they will interfere with the autoimmune feedback loop that goes from damaged neurons, to the alpha synuclein and neuromelanin they dump out as they die, to the receptors on microglia (part of the innate immune system) that are triggered by those substances, to the inflammatory cytokines (e.g., TNF-alpha) produced by those microglia, back to other, formerly-healthy 'bystander' neurons that get damaged by the cytokines, which starts the cycle over again.",
    publication_type: news,
    is_private: false,
    community: parkinson,
    user: members.sample,
  },
  { title: "Going to Washington DC to advocate for Parkinson",
    content: "I am so excited to have been chosen buy the Parkinson's policy forum to go to Washington to speak to our legislators about the needs of people with Parkinson's. I leave this Sunday I can't wait to meet everyone there. We are going to be talking about the need for more research, a cap on medication for people on Medicare's medicine. We will also talk about the high cost of medicines. I hope we make a difference.",
    publication_type: news,
    is_private: false,
    community: parkinson,
    user: members.sample,
  },
  { title: "Oral CBD (from hemp) and sleep; also, difficulty getting diagnosis and DaTscan",
    content: "Does oral CBD (hemp extract) help with sleep for Parkinson patients?
      My husband will be 73 this September and has a tentative diagnosis of early Parkinson. We are both stressed and he needs something to help him sleep right now, coming to terms with this possible diagnosis.
      He has an order for the DaTscan. I found this website from the brochure the neurologist gave us on the DaTscan.
      Have any of you had the DaTscan and is it worth it to make a firm diagnosis of Parkinson disease? He has other issues going on and this is an added stressor.",
    publication_type: question,
    is_private: false,
    community: parkinson,
    user: members.sample,
  },
  { title: "Sleep problems with PD",
    content: "I was recently diagnosed with PD. This was about 6 months ago and I am experiencing a need to sleep more. I find I need a nap most of the time two times a day. Is this common with PD? I sleep well at night except I experience bad dreams--some I remember and others I don't.",
    publication_type: question,
    is_private: false,
    community: parkinson,
    user: members.sample,
  },
  { title: "PD Warrior exercise program",
    content: "In one of these conversations someone mentioned PD Warrior, an exercise program for Parkinsons. It is supposed to be specific exercises targeted to slow the progression of PK. They say they do not have a licensed facility in the US but are working on it. However, they have an online program called the 10 week challenge. They say that these exercises can be done at home. Is there anyone who has information or has had experience with PD Warrior? I am considering it in addition to Rock Steady Boxing, which I am doing 3 times a week.",
    publication_type: question,
    is_private: false,
    community: parkinson,
    user: members.sample,
  },
]

publications.each do |publication|
  pub = Publication.create!(publication)

  if rand() > 0.8
    url = "https://source.unsplash.com/1600x900/?treatment#{rand(20)}"
    pub.remote_photo_url = url
  end
  rand(1..2).times do
    members = parkinson.users
    # possible_clappers = User.where.not(id: author)
    # clapper = possible_clappers.sample
    Clap.create!(publication: Publication.last, user: members.sample)
    # possible_clappers.delete!(clapper)
  end

  user1 = members.sample
  user2 = pub.user
  user3 = members.sample
  Comment.create!(publication: Publication.last, user: user1, content: "I know someone who might know more about it, I'll ask her")
  Comment.create!(publication: Publication.last, user: user2, content: "That's really nice, thanks!")
  if rand() > 0.5
    Comment.create!(publication: Publication.last, user: user3, content: "I also may know someone, I'll let you you know")
    if rand( ) > 0.5
      Comment.create!(publication: Publication.last, user: user2, content: "Thanks! :)")
    end
  end
end




puts '--- creating them for the Stroke community'
  # members = User.joins(:community_users).where(community_users:{community: community})
members = stroke.users

publications = [
  { title: "Welcome to the Stroke Community!",
    content: "Welcome! We're glad to have you as part of our stroke community where patients and family members can share their experience, support, and helpful information with each other. We talk about stroke, TBI (traumatic brain injury), and related problems.
      Thank you for being a part of the Buddy Steps community. You’re helping to create a safe and supportive environment where patients and their family caregivers can learn from each other. We look forward to getting to know you!",
    publication_type: news,
    is_private: false,
    community: stroke,
    user: members.sample
  },
  { title: "Feeling weak, antsy, unstable before Carbadopa/Levadopa",
    content: "My husband takes Carbadopa/Levadopa every three hours. Sometimes the doses come and go well, but once or twice in a day he can begin to feel antsy/anxious, weak, and unstable. This can happen just before or after a dose, and last up to an hour. Does anyone else experience this?",
    publication_type: question,
    is_private: false,
    community: stroke,
    user: members.sample
  },
  { title: "Acquired alexia following stroke",
    content: "Has anyone in the heart transplant community ever experienced this with their loved one? Trying to figure out how to help my husband through this. Actually have to help him learn to read and process it. On waiting list for an OT. My husband is extremely frustrated, and I’m losing my compassion. Thanks for any feedback.",
    publication_type: question,
    is_private: false,
    community: stroke,
    user: members.sample
  },
  { title: "Early Onset Diagnosis",
    content: "Hello,
      I am 48 and have recently been diagnosed with Parkinson's. My father has the disease as well. My symptoms began about 3 years ago but my physician just felt it was stress related symptoms. I began with a tremor in my right index finger, surreal dreams all night, every night, leg stiffening and pain, cognitive difficulty (like I had a response to things 5 seconds too late), word difficulty and mobility issues with walking. It was like I was listing on a boat. I began to fall a lot. Since that time it has progressed to my right arm, hand and at times my right leg have tremors. Now certain fingers on my left are beginning to tremor. My memory is very, very bad, abnormally so.
      My husband is very supportive and I am tremendously thankful for this. My neurologist has me currently taking 1 mg of Requip and 0.25 of Azilect. The tremors are better so far but today is my first day being increased to this level of meds.
      When I have significant tremors in my right side, I feel like I am having tremors on the inside of my body as well. Is this common for others?
      When I was first diagnosed, I felt like 'Ok, let's get this addressed, on meds and move forward.'' But I am finding it is a bit more difficult than that. It goes much deeper and I am having a difficult time adjusting to it. So many changes in how I live. I run a farm and am physically struggling with things, we have several flights of stairs in our home that are difficult to maneuver due to being off-balance. My memory makes taking care of our finances a bit challenging. I am finding I am making mistakes I have never made before. I have started to stutter and really fight for words. It's in my head somewhere, I just can't get it out. It is embarrassing in public.
      I have found a support group about 45 minutes from where we live. I also exercise everyday in some form or fashion. I bought a boxing bag and gloves for my home. I figure I would try and teach myself. We live very rural so it is difficult to find certain amenities that one would have available in say, larger cities. My neurologist does not want to start speech therapy or physical therapy until I am more settled with my medications. She has also scheduled a DaTscan for me to take.
      I am losing weight on the Requip. My neurologist says this should not be caused by the Requip but I feel it is. Does anyone else have this issue?
      I thank you in advance for reading this note about my experience with PD. I mainly just needed to reach out to someone who knows what it is like. It is isolating and overwhelming at times.",
    publication_type: question,
    is_private: false,
    community: stroke,
    user: members.sample
  },
  { title: "What does health insurance do to prevent fraud?",
    content: "Like most of us, William Murphy dreads calling health insurance companies. They route him onto a rollercoaster of irrelevant voice menus, and when he finally reaches a human, it’s a customer service rep who has no idea what he’s talking about. Then it can take days to hear back, if anyone responds at all.
      The thing is, Murphy isn’t a disgruntled patient. He prosecutes medical fraud cases for the Alameda County District Attorney’s Office in Oakland, California. And when he calls insurers, he’s in pursuit of criminals stealing from them and their clients. But, he said, they typically respond with something akin to a shrug. “There’s no sense of urgency, even though this is their company that’s getting ripped off.”
      It’s not just Murphy. I called health care fraud prosecutors across California to ask what insurers were doing to help bring cases against those plundering health care dollars. More than one simply burst out laughing. “Not much,” one prosecutor said.
      It seems counterintuitive. Escalating health care costs are one of the greatest financial concerns in the United States. And an estimated 10% of those costs are likely eaten up by fraud, experts say. Yet private health insurers, who preside over some $1.2 trillion in spending each year, exhibit a puzzling lack of ambition when it comes to bringing fraudsters to justice.",
    publication_type: news,
    is_private: false,
    community: stroke,
    user: members.sample
  },
  { title: "Stroke recovery",
    content: "My husband had a hemorrhagic stroke five weeks ago. He has made good progress with his recovery but is quite depressed and anxious. While I know this goes along with the stroke, I would like to know how others have handled this.",
    publication_type: question,
    is_private: false,
    community: stroke,
    user: members.sample
  },
  { title: "Stroke Patient",
    content: "Hello,
      My name is Tori i am new to this but i am seeking help for my mother she had a stroke on her left side which affected her right side. She can get around really good she can walk and everything we are working on trying to build her strength completely back up on her right side like using her right arm she barely uses it she uses her left but she can walk really well it also affected her speech she take speech therapy but i am seeking a little more help.",
    publication_type: question,
    is_private: false,
    community: stroke,
    user: members.sample
  },
  { title: "New secondary hypertension and stroke",
    content: "Hi stroke community, I am a stroke patient in my thirties in ongoing recovery, and am still undergoing medical follow-ups for the source cause(s).
      I wanted to ask those, who were comfortable to share here, who have had experience (personal or tangential) with stroke and secondary hypertension and what resolutions came out of that as far as BP correlation to stroke and/or detecting the cause. I'm sorry if this is unclear. I don't mean for medical details or decisions, but am interested in a general sense of insight that folks have gained for managing their own health journey with secondary hypertension and stroke. Any level of sharing is welcome. Thank you.",
    publication_type: question,
    is_private: false,
    community: stroke,
    user: members.sample
  },
  { title: "Help for Caregiver of Stroke Patient",
    content: "My husband had a stroke 6 months ago, and he was very lucky that it didn’t leave him with many physical residuals of the stroke.
      But my frustration is that he won’t do any occupational or speech exercises at home and when I remind him, he freaks out at me. He was discharged already from formal therapy. I know this would help him but he just won’t do it.
      Beyond frustrated. Any help would be appreciated!",
    publication_type: question,
    is_private: false,
    community: stroke,
    user: members.sample
  },
]

publications.each do |publication|
  pub = Publication.create!(publication)

  if rand() > 0.8
    url = "https://source.unsplash.com/1600x900/?treatment#{rand(20)}"
    pub.remote_photo_url = url
  end
  rand(1..2).times do
    members = stroke.users
    # possible_clappers = User.where.not(id: author)
    # clapper = possible_clappers.sample
    Clap.create!(publication: Publication.last, user: members.sample)
    # possible_clappers.delete!(clapper)
  end

  user1 = members.sample
  user2 = pub.user
  user3 = members.sample
  Comment.create!(publication: Publication.last, user: user1, content: "I know someone who might know more about it, I'll ask her")
  Comment.create!(publication: Publication.last, user: user2, content: "That's really nice, thanks!")
  if rand() > 0.5
    Comment.create!(publication: Publication.last, user: user3, content: "I also may know someone, I'll let you you know")
    if rand( ) > 0.5
      Comment.create!(publication: Publication.last, user: user2, content: "Thanks! :)")
    end
  end
end




puts '--- creating them for the Cancer community'
  # members = User.joins(:community_users).where(community_users:{community: community})
members = cancer.users

publications = [
  { title: "Husband's bed in living room",
    content: "My husband had two strokes about five years ago. At the time, there was a hospital bed in the living room because my dad had been in it for a while. So after my dad passed, the bed stayed where it was. So my husband used it after his strokes. Well, five years later, he is still in the living room and I need to get him in his own room and I am finding resistance. What can I do? Thanks",
    publication_type: question,
    is_private: false,
    community: cancer,
    user: members.sample
  },
  { title: "Dealing with cancer",
    content: "Hello. I am new to the forum. I am both a cancer survivor and have a loved one losing the battle. Is this a site only for good results or the entire journey? Ty",
    publication_type: question,
    is_private: false,
    community: cancer,
    user: members.sample
  },
  { title: "Sarcomatoid Carcinoma of the larynx",
    content: "A person with this rare cancer bumped into the Sarcomatoid RCC FB group. Does anyone have an idea of a relevant support group for this person?
      If you can thing of a better tag than Cancer, tell me and I will add it. (Or add it yourself if you can.)
      ??",
    publication_type: question,
    is_private: false,
    community: cancer,
    user: members.sample
  },
  { title: "Seminar for Cancer Survivors in central MA",
    content: "For those of you that live in central MA, I wanted to share a free workshop being offered Tuesday Nov 6th. It is being sponsored by CaSfA, Cancer Support for All.
      Title: Navigating Employment After a Cancer Diagnosis
      -- if/when to share a cancer diagnosis
      -- cancer and job search
      -- resources to help
      RSVP to Joanne Sullivan at CaSfAgroup@gmail.com",
    publication_type: news,
    is_private: false,
    community: cancer,
    user: members.sample
  },
  { title: "Source of financial help for those of us on Medicare",
    content: "Are you a patient struggling to afford the cost of medical treatments?
      When health insurance is not enough, we’re here to help — with copays, premiums, deductibles and out-of-pocket expenses for supplies, supplements, surgeries and more. We offer financial assistance through a number of Disease Funds, with new funds opening every year, so you can get the care you need.",
    publication_type: news,
    is_private: false,
    community: cancer,
    user: members.sample
  },
  { title: "No need for a silver bullet we have a golden egg!",
    content: "Aesop’s tale of the goose that laid the golden egg ended with some greedy farmers butchering the bird for the gold they presumed was inside. But there’s no way the “golden egg”-laying hens that Japanese scientists recently developed will experience such harm. The hens, which lay extremely valuable eggs containing a protein crucial to cancer and hepatitis treatment, are far too precious to scientists to meet such a gruesome end.
      The scientists from Japan’s Biomedical Research Institute at the National Institute of Advanced Industrial Science and Technology published a paper on their genetically modified hens in Scientific Reports in July. They’re in the spotlight now because the Telegraph reported on Monday that the team would collaborate with the biotech firm Cosmo Bio to raise the hens and commercially harvest the precious virus-fighting protein, known as human interferon beta, from the eggs for use in research. Currently, Cosmo Bio’s Mika Kitahara told the Telegraph, the company has about 20 in-house hens.
      This isn’t the first time humans have manipulated protein production in other animals. Proteins crucial to the flu vaccine have been produced in chicken eggs, and proteins key to spider silk are being pumped out in goat’s milk (which is also protein rich). But the value of those experiments pale in comparison to that of a single golden egg, which, containing about 30 to 60 milligrams of interferon beta, is estimated to be worth between $535,995 and $2.6 million.",
    publication_type: news,
    is_private: false,
    community: cancer,
    user: members.sample
  },
  { title: "DreamLab for cancer research",
    content: "The Garvan Institute, a respected cancer research center in Australia, has created DreamLab, an app that uses downtime on your cell phone to crunch data on cancer.
      It is now available to those of us who have iPhones. I just downloaded the app because Dr. David Thomas at the Garvan Institute has done amazing research on genomics and sarcoma.",
    publication_type: news,
    is_private: false,
    community: cancer,
    user: members.sample
  },
  { title: "Best to avoid Britain if diagnosed with cancer",
    content: "The UK is trailing behind other European countries when it comes to diagnosing and treating cancer, a new report says.
      The study, commissioned by the Association of the British Pharmaceutical Industry (ABPI) - which represents drugs firms, also points to worse survival rates in the UK.
      Compared to the average for Europe, the UK lags behind on nine out of 10 cancers when it comes to survival - including bowel, lung, breast, ovarian, prostate and kidney cancer.
      The UK has the second worst survival rates for lung cancer and the second worst survival for pancreatic cancer.
      The UK also spends more than 20 per cent less per person on cancer than other EU economies - including the Netherlands, Italy and France, the report from Swedish researchers said.
      According to the analysis, if the UK achieved the cancer survival rates of Germany, more than 35,000 more people would be alive five years after diagnosis.
      And if the UK had the cancer death rates of France, more than 100,000 women's deaths could be prevented over the next decade.",
    publication_type: news,
    is_private: false,
    community: cancer,
    user: members.sample
  },
  { title: "RCC (any cancer) and stroke risk",
    content: "I had a stroke a year ago (today) that I fully recovered from. I asked then on SP about cancer and strokes, but maybe I will get something different now, or more ideas.
      Anything I looked into or heard showed just a general idea that cancer patients are more at risk for strokes. Which doesn't sound like it means much to me: any diminished health is bound to increase your risk of a stroke (of heart attacks, etc.)
      I have to admit that I was kind of complacent in the aftermath. I did do something about it, but having a stroke just didn't motivate me like having the big C.
      I am generally quite healthy. Good weight. Very low blood pressure for my age. Not Stage 4, and have had no drug treatments. The stroke came about 16 weeks after my nephrectomy. I recovered fabulously from the operation, but the voracious tumour was taking more than half my blood supply, and was near to killing me before the operation.
      I had a grandfather who had two strokes. Late 50's- the first one left him without a lot of capacity. The second one a year or so later, finished him off. He was also lean, do not think he smoked. Drank fairly moderately.
      After the stroke I had MRIs and CT scans to the yin yang- no signs of anything anywhere that contributed to the stroke.",
    publication_type: question,
    is_private: false,
    community: cancer,
    user: members.sample
  },
]

publications.each do |publication|
  pub = Publication.create!(publication)

  if rand() > 0.8
    url = "https://source.unsplash.com/1600x900/?treatment#{rand(20)}"
    pub.remote_photo_url = url
  end
  rand(1..2).times do
    members = cancer.users
    # possible_clappers = User.where.not(id: author)
    # clapper = possible_clappers.sample
    Clap.create!(publication: Publication.last, user: members.sample)
    # possible_clappers.delete!(clapper)
  end

  user1 = members.sample
  user2 = pub.user
  user3 = members.sample
  Comment.create!(publication: Publication.last, user: user1, content: "I know someone who might know more about it, I'll ask her")
  Comment.create!(publication: Publication.last, user: user2, content: "That's really nice, thanks!")
  if rand() > 0.5
    Comment.create!(publication: Publication.last, user: user3, content: "I also may know someone, I'll let you you know")
    if rand( ) > 0.5
      Comment.create!(publication: Publication.last, user: user2, content: "Thanks! :)")
    end
  end
end




puts '--- creating them for the Diabetes community'
  # members = User.joins(:community_users).where(community_users:{community: community})
members = diabetes.users

publications = [
  { title: "5 Star Grocery Items?",
    content: "We’d appreciate hearing of grocery items that are “go-to’s” for parents of T1 children. Our recent delicious discoveries are:
      1) OIKOS Triple Zero Greek Yogurt....10 carbs and 8 protein (100 g package in Canada). There’s a 15 carb version in the States that we prefer.
      2) fairlife milk....6 carbs and 14 protein per cup
      Thank you!",
    publication_type: question,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
  { title: "Freestyle Libre",
    content: "I would love to get your opinion of Libre. Am I the only one having such trouble?
      I was so happy to trial the Libre cgm but quite disappointed with the 30 point discrepancy. I realize that the measurement is usually 15-20 minutes delayed and it measures interstitial etc. This does not account for gross discrepancy I experience. I called company and received a new sensor. Also tried rotating the spot.
      I've been thru 4 sensors now with poor accuracy and plan to ask company for a new meter, too.
      Anyone have difficulty and did you resolve it any way?",
    publication_type: question,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
  { title: "Hypoglycemic episodes",
    content: "I am type 2. Over the last 9 to 10 months I have been having hypo episodes - most of which required an ER visit and some of the time admission. My doc says I’m doing everything right to correct the event but they continue to happen. I am so tired of it happening. Need support, advice",
    publication_type: question,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
  { title: "Husband’s PC was found by chance by an alert PC doctor",
    content: "My husband was rushed thru a dissection of his pancreas middle and tail and spleen. He is level 1B. Recovered very rapidly. And starts his second chemo on this Wednesday. Only problem is a low cramping in gut and oncologist said it is side affect of one drug which lasts about 10 days in some patients. Doctor put him on a drug to help and it does.
      Sorry, I don’t know all the medical lingo but am learning.
      My husband has another problem which started almost 1 year before the PC. He is now an insulin dependent diabetic. Since one of his chemo drugs has dextrose in it his diabetes will be off for awhile (this was foreseen). But my husband is concerned if his glucose goes up to 200 when he usually is able to control it to below 140.
      Now two questions. Are there any PC patients that we could hear from on a stage 1? I know my husband’s prognosis is favorable and his surgeon and oncologist say he is a 72 year old man in great physical shape besides all the problems but would love to hear what others have experienced.
      The other question is about the diabetes. Anyone else stressed out about it?
      Thanks for any help.♥️",
    publication_type: question,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
  { title: "Penile Implant Surgery",
    content: "A year ago July I had a penile implant surgery due to ED caused by diabetes. I had tried all the other aproaches to correcting the issue, but they all fell short. For anyone thinking of having the surgery, I would wholeheartedly say go for it. I wish I had done it years earlier. Feel free to ask me any questions.",
    publication_type: question,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
  { title: "Finding ways to save on diabetic supplies",
    content: "I have been having problems with getting enought diabetic testing strips from my insurance company. So I researched how to find them over the counter. Well I found them on Amazon for half of the price and I can order them whenever I want. Now I just want to test the quality. Will get back to you all. Check it out if you use Contour Next Strips.",
    publication_type: question,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
  { title: "Had a small stroke due to diabetes",
    content: "Hi, I'm Karyn and don't know how to sign in or much technology. Thank you for letting me join this group. It is very helpful. I've had type 1diabetes for over 40 years, and heart bypass over 10 years ago. I had a small stroke, and my Doctors said that is typical for type 1 diabetes. I'm not very good at writing or people understand what I write or say. I hope I made it clear. Thank you all for sharing. I appreciate it.",
    publication_type: question,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
  { title: "About this trial: Teneligliptin Versus Linagliptin in Diabetes Mellitus Type Two Patients",
    content: "Looking at Pubmed I could not find publication of results of this study (and since the average time to publication after a study has completed is about two years, I would not expect it just yet). However, since the study was by a drug company, the results might never be published, unfortunately.
      I did find one study, published by different researchers, that addresses many other studies that include these two medicines; unfortunately, only the abstract is available to all, but perhaps your doctor has access to the full paper:",
    publication_type: news,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
  { title: "hot weather factor?",
    content: "Hi,
      This is my six month diaversary (type 1) and I am noticing that in spite of doing everything the same my number is lower than usual and it doesn't rise like it used to. The weather is hot, I am busy, drinking a lot more water. Does this make sense? I want to avoid hypo but I don't want to eat when I'm not hungry just to maker my number go up. What should I do? Lantus is 6, usual bgs are 110, now 90s or high 80s. Doc is not going to be happy!",
    publication_type: question,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
  { title: "Metabolic syndrome",
    content: "After losing weight I was told that I would have to stop exercising for 6-8 weeks as exercise is keeping my reading high. Has anyone else experienced this and what did u do?",
    publication_type: question,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
  { title: "Type 1 LADA diabetes at 50 Any tips?",
    content: "I already have 2 autoimmune diseases, now a 3rd, type 1 LADA diabetes. Anyone in a similar situation? My blood glucose goes from almost hypo to almost hyper in the same day, anything effects it... Stress, too hot, too cold, too much walking, too little walking...not to mention the very limited diet I have No two days are the same even if I follow the same routine. My medication has been changed a number of times. Finding it hard. Any tips?",
    publication_type: question,
    is_private: false,
    community: diabetes,
    user: members.sample
  },
]

publications.each do |publication|
  pub = Publication.create!(publication)

  if rand() > 0.8
    url = "https://source.unsplash.com/1600x900/?treatment#{rand(20)}"
    pub.remote_photo_url = url
  end
  rand(1..2).times do
    members = diabetes.users
    # possible_clappers = User.where.not(id: author)
    # clapper = possible_clappers.sample
    Clap.create!(publication: Publication.last, user: members.sample)
    # possible_clappers.delete!(clapper)
  end

  user1 = members.sample
  user2 = pub.user
  user3 = members.sample
  Comment.create!(publication: Publication.last, user: user1, content: "I know someone who might know more about it, I'll ask her")
  Comment.create!(publication: Publication.last, user: user2, content: "That's really nice, thanks!")
  if rand() > 0.5
    Comment.create!(publication: Publication.last, user: user3, content: "I also may know someone, I'll let you you know")
    if rand( ) > 0.5
      Comment.create!(publication: Publication.last, user: user2, content: "Thanks! :)")
    end
  end
end






# puts "creating Publications for users' diaries"
# User.all.each do |user|
#   5.times do
#     paragraphs =
#       [
#         Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s,
#         Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s,
#         Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s,
#         Faker::Lorem.paragraph_by_chars(number: rand(250...350)).to_s
#       ]
#     text = paragraphs.first(rand(2..4)).join("\n\n")

#     publication = Publication.create!(
#       title: Faker::TvShows::TwinPeaks.quote,
#       content: text,
#       publication_type: [frustration, pleasure].sample,
#       is_private: true,
#       user: user
#     )
#     rand(1..3) do
#       Clap.create!(publication: publication, user: User.all.sample)
#     end
#   end
# end

puts '---------------------------------------'
puts 'Seed is complete'
