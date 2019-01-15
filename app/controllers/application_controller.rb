class ApplicationController < ActionController::Base
    before_action :get_category
    protect_from_forgery with: :exception
    include SessionsHelper
    def get_category
       @categories = Category.all 
    end    
    
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
