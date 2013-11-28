class PagesController < ApplicationController
  protect_from_forgery with: :exception
  
  def about
    @title="About"
  end
  
  def home
    @title="Home"
  end
end
