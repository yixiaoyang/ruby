namespace :db do
  desc "Fill Data for Project"
  # 保证raker获取到rails环境信息包括User模型
  task populate: :environment do
    make_users
    make_channels
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


def make_channels  
  15.times do |n|
    title = "Channel#{n}"
    description = "Description for Channel #{n}"
    url = "www.baidu.com/news/rss/channel/#{n}"
    user_id = n%10+1
    Channel.create!(url:url,
                    title:title,
                    user_id:user_id,
                    description:description)
  end
end