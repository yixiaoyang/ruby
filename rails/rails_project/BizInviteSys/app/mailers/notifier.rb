class Notifier < ActionMailer::Base
  default from: "admin@biz.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_user.subject
  #
  def email_user(user)
    @user = user
    if  @user.nil?
      redirect_to not_found_path
    end
    @greeting = "Hi"
    @sender_name = "Biz invitation"

    mail :to =>  @user[:email], :subject => "Reset your password"
    p "send mail to #{@user.email} ok"
  end
  
  def test
    users = User.where("email = ?", 'hityixiaoyang@qq.com').limit(1)
    Notifier.email_user(users[0])
  end
end
