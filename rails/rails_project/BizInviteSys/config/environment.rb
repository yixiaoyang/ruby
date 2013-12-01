# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
BizInviteSys::Application.initialize!

# 自定义全局常量区域

# email regex
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
SEX_WORDS = ["male","female"]
SEX_WORDS_OPTIONS = [["male",0],["female",1]]

DEGREE_WORDS = ["Bachelor","Master","Doctor","Other"]
SKILL_CATEGORY_WORDS = ["Should", "General", "Other"]
PROFILE_CATEGORY_WORDS = ["School","Society"]
PROFILE_STATS_WORDS = ["Pass","Pending","Reject"]

