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
# 改进：！！！使用yaml配置文件代替！！！

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

PROFILE_CATEGORY_WORDS = ["School Invitation","Society Invitation"]
PROFILE_CATEGORY_WORDS_OPTIONS = mk_options(PROFILE_CATEGORY_WORDS)

PROFILE_STAT_STYLES = ["badge-inverse","badge-info","badge-warning","badge-important","badge-success",""]
# 未投递，已投递（未审核），通过（不能在），未决，未通过
PROFILE_STATS_WORDS = ["Undelivered","Delivered","1st Interview","2nd Interview","Passed","Reject"]
# for admin
PROFILE_STATS_HASH = {
  0 => [2,3,4,5], # Undelivered->Delivered, current_stat => {next_available_stats}
  1 => [2,3,4,5],
  2 => [3,4,5],
  3 => [4,5],
  4 => [1,5], #Passed => {Reject}
  5 => [1]  #Reject => {Delivered}
}
# for normal user
PROFILE_STATS_USER_HASH = {
  0 => [1], 
  1 => [0],
  2 => [0],
  3 => [0],
  4 => [0],
  5 => [0] 
}

PROFILE_STATS_WORDS_OPTIONS = mk_options(PROFILE_STATS_WORDS)

EDUCATION_START_END_TIME = {syear:1960, smonth:1, sday:1}

# form 
AGE_MIN = 16
AGE_MAX = 100
AGE_OPTIONS_FOR_INPLACE = Array.new(AGE_MAX-AGE_MIN+1){|i| [i+AGE_MIN, (i+AGE_MIN).to_s]}

DESCRIPTION_LEN_MAX = 1000
VLUATION_LEN_MAX = 1000
