require 'spec_helper'

describe PagesController do
  subject { page }
  
  it "should have the right links on the layout" do
    visit home_path
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Contact"
    expect(page).to # fill in
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to # fill in
  end
  

    describe "Home page" do
      it "should have the content 'Home'" do
        visit home_path
        expect(page).to have_content('Home')
      end
      it "should have the title 'Home'" do
        visit home_path
        expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
      end
   end

  describe "Contact page" do
    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Contact")
    end
  end

  describe "About page" do

    it "should have the content 'About'" do
      visit about_path
      expect(page).to have_content('About')
    end

    it "should have the title 'About'" do
      visit about_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About")
    end
  end
end
