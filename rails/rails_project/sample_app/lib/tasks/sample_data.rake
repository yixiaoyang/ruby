namespace :db do
  desc "Fill Data for sampleApp"
  # 保证raker获取到rails环境信息包括User模型
  task populate: :environment do
    make_users
    make_microposts
    make_relationships
  end
end

def make_users
  # create!方法如果信息不合法会抛出异常而不返回false
  User.create!(name:"User",
               email:"user@ex.com",
               password:"123456",
               password_confirmation:"123456",
               # 把第一个用户设置为管理员
               admin:true)
  50.times do |n|
    name = "user#{n}"
    email = "user#{n}@ex.com" 
    password = "123456"
    User.create!(name:name,
                 email:email,
                 password:password,
                 password_confirmation:password )
  end
end

def make_microposts
  # 批量生成micropost数据
  users = User.all(limit:5)
  20.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end 
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..20]
  followers      = users[3..10]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

