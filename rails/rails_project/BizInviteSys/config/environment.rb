# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
BizInviteSys::Application.initialize!

# generate options
def mk_options(arr, for_best_in_place=false)
  cnt = 0
  option_arr = []
  arr.each{ |val|
    if for_best_in_place
          option_arr[cnt] = [cnt,arr[cnt]]
    else
      option_arr[cnt] = [arr[cnt],cnt]
    end
    cnt+=1
  }
  option_arr
end

# 自定义全局常量区域

# email regex
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

SEX_WORDS = ["male","female"]
SEX_WORDS_OPTIONS = mk_options(SEX_WORDS)
SEX_WORDS_OPTIONS_FOR_INPLACE = mk_options(SEX_WORDS,true)

DEGREE_WORDS = ["Bachelor","Master","Doctor","Other"]
DEGREE_WORDS_OPTIONS = mk_options(DEGREE_WORDS)
DEGREE_WORDS_OPTIONS_FOR_INPLACE= mk_options(DEGREE_WORDS,true)

SKILL_CATEGORY_WORDS = ["Important", "General", "Other"]
SKILL_CATEGORY_STYLES =["badge-important","badge-warning","badge-success"]
SKILL_CATEGORY_WORDS_OPTIONS = mk_options(SKILL_CATEGORY_WORDS)

PROFILE_CATEGORY_WORDS = ["School","Society"]
PROFILE_CATEGORY_WORDS_OPTIONS = mk_options(PROFILE_CATEGORY_WORDS)

PROFILE_STATS_WORDS = ["Pass","Pending","Reject"]
PROFILE_STATS_WORDS_OPTIONS = mk_options(PROFILE_STATS_WORDS)

EDUCATION_START_END_TIME = {syear:1960, smonth:1, sday:1}

# form 
AGE_MIN = 16
AGE_MAX = 100
AGE_OPTIONS_FOR_INPLACE = Array.new(AGE_MAX-AGE_MIN+1){|i| [i+AGE_MIN, (i+AGE_MIN).to_s]}

DESCRIPTION_LEN_MAX = 1000