# demo
# user.firstname = Faker::Name.first_name
# user.lastname = Faker::Name.last_name
# user.email = Faker::Internet.email
# user.encrypted_password = User.new(:password => password).encrypted_password
# user.phone   = Faker::PhoneNumber.phone_number
# user.address1  = Faker::Address.street_address
# user.city    = Faker::Address.city
# user.state   = Faker::Address.state_abbr
# user.zip     = Faker::Address.zip_code
# user.latitude = Faker::Address.latitude
# user.longitude = Faker::Address.longitude
# 
# t.title = Faker::Lorem.sentence(word_count=15)
# t.details = Faker::HipsterIpsum.paragraphs(sentence_count=3)
# t.group_id = rand(6)+1 # random group_id [1..6]
# t.status_id = 1
# t.priority_id = rand(3)+1 # random priority_id [1..3]
# t.contact_id = rand(NUM_CONTACTS)+1 # random contact_id [1..NUM_CONTACTS]
# t.creator_id = rand(6)+2 # random created_by [2..7]
# t.created_at = CREATION_PERIOD.sample

# SEX_WORDS = ["male","female"]
# DEGREE_WORDS = ["Bachelor","Master","Doctor"]
# CATEGORY_WORDS = ["Should", "General", "Other"]
# PROFILE_CAT = ["School","Society"]
# PROFILE_STATS = ["Pass","Pending","Reject"]

namespace :db do
  desc "Generate Data for Project"
  task gen_all: :environment do
    make_users
    make_personalDetails
    make_educations
    make_skills
    make_skill_items
    make_profiles
    make_comments
  end
  
  desc "Generate Data for Project"
  task populate: :environment do
    make_users
  end
  
  desc "Generate personalDetails for Project"
  task personalDetails:  :environment do
    make_personalDetails
  end
  
  desc "Generate education for Project"
  task educations:  :environment do
    make_educations
  end

  desc "Generate skills for Project"
  task skills:  :environment do
    make_skills
    make_skill_items
  end
  
  desc "Generate profiles for Project"
  task profiles:  :environment do
    make_profiles
  end
  
  desc "Generate comments for Project"
  task comments:  :environment do
    make_comments
  end
  
end

def make_users
  5.times do |n|
    name = "user#{n}"
    User.create!(name:name,
               email:"#{name}@biz.com",
               password:"123456",
               password_confirmation:"123456",
               admin:true)
  end
  
  50.times do |m|
    n = m+5
    name = "user#{n}"
    email = "user#{n}@biz.com" 
    password = "123456"
    User.create!(name:name,
                 email:email,
                 password:password,
                 password_confirmation:password,
                 admin:false)
  end
end

def make_personalDetails
  20.times do |n|
    name = Faker::Name.first_name+"."+ Faker::Name.last_name
    # 18..38
    age = rand(20) + 18 
    # 0..1, male, female
    sex = rand(SEX_WORDS.size)
    mobile =  Faker::PhoneNumber.phone_number
    email = Faker::Internet.email
    
    PersonalDetail.create!(name:name,
                 age:age,
                 sex:sex,
                 email:email,
                 mobile:mobile,
                 profile_id:n+1)
  end
end

def make_educations
  20.times do |n|
    #timeZone = "#{rand(9)+1995}/#{rand(12)+1}-#{rand(8)+2005}/#{rand(12)+1}"
    # .to_formatted_s(:year_and_month)
    stime = Time.new(rand(9)+1995, rand(12)+1,1)
    etime = Time.new(rand(8)+2005, rand(12)+1,1)
    degree = rand(DEGREE_WORDS.size)
    description =  Faker::Lorem.sentence(word_count=15)
    Education.create!(stime:stime,
                      etime:etime,
                      degree:degree,
                      description:description,
                      profile_id:n+1)
  end
end


def make_skills
  20.times do |n|
    score = rand(10) + 2
    category = rand(SKILL_CATEGORY_WORDS.size)+0
    description =  Faker::Lorem.sentence(word_count=15)
    Skill.create!(score:score,
                      category:category,
                      description:description)
  end
end

def make_skill_items
  10.times do |prodile_id|
    6.times do |n|
      skill_id = n;
      SkillItem.create!(profile_id:prodile_id+1,
                    skill_id:n+1)
    end
  end
end

def make_profiles
  20.times do |n|
    category = rand(PROFILE_CATEGORY_WORDS.size)
    score = rand(10) + 60
    stat = rand(PROFILE_STATS_WORDS.size)
    Profile.create!(score:score,
                  category:category,
                  stat:stat,
                  user_id:n+1)
                 end
end

def make_comments
  20.times do |n|
    score = rand(50) + 50
    vluation =  Faker::Lorem.sentence(word_count=15)
    user_id = rand(5)+1
    Comment.create!(score:score,
                  vluation:vluation,
                  profile_id:n+1,
                  user_id:user_id)
  end
end