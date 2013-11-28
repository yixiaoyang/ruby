namespace :db do
  desc "Generate Data for Project"
  task populate: :environment do
    make_users
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