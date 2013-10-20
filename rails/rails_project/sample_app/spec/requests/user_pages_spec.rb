require 'spec_helper'
require 'pages_helper'

describe "Sign up Pages" do
  describe "GET /user_pages" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get signup_path
      response.status.should be(200)
    end
  end
  
  subject { page }
  describe "Check signup title" do
    before { visit signup_path }
    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end
end
