# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
BizInviteSys::Application.initialize!

# 自定义全局常量区域

# email regex
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i