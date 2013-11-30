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

SEX_WORDS = ["male","female"]
DEGREE_WORDS = ["Bachelor","Master","Doctor"]
CATEGORY_WORDS = ["Should", "General", "Other"]

namespace :db do
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
  end

end

def make_users
  User.create!(name:"User",
               email:"user@biz.com",
               password:"123456",
               password_confirmation:"123456",
               # 把第一个用户设置为管理员
               admin:true)
  50.times do |n|
    name = "user#{n}"
    email = "user#{n}@biz.com" 
    password = "123456"
    User.create!(name:name,
                 email:email,
                 password:password,
                 password_confirmation:password )
  end
end

def make_personalDetails
  50.times do |n|
    name = Faker::Name.first_name+"."+ Faker::Name.last_name
    # 18..38
    age = rand(20) + 18 
    # 0..1, male, female
    sex = SEX_WORDS[rand(2)+0]
    mobile =  Faker::PhoneNumber.phone_number
    email = Faker::Internet.email
    PersonalDetail.create!(name:name,
                 age:age,
                 sex:sex,
                 email:email,
                 mobile:mobile )
  end
end

def make_educations
  20.times do |n|
    timeZone = "#{rand(9)+1995}/#{rand(12)+1}-#{rand(8)+2005}/#{rand(12)+1}"
    degree = DEGREE_WORDS[rand(3)+0]
    description =  Faker::Lorem.sentence(word_count=15)
    Education.create!(timeZone:timeZone,
                      degree:degree,
                      description:description)
  end
end


def make_skills
  20.times do |n|
    score = rand(10) + 2
    category = CATEGORY_WORDS[rand(3)+0]
    description =  Faker::Lorem.sentence(word_count=15)
    Skill.create!(score:score,
                      category:category,
                      description:description)
  end
end