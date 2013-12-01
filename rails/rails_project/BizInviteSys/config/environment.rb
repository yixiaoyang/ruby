# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
BizInviteSys::Application.initialize!

# 自定义全局常量区域

# email regex
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
SEX_WORDS = ["male","female"]
DEGREE_WORDS = ["Bachelor","Master","Doctor"]
CATEGORY_WORDS = ["Should", "General", "Other"]
PROFILE_CAT = ["School","Society"]
PROFILE_STATS = ["Pass","Pending","Reject"]