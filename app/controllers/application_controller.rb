class ApplicationController < ActionController::Base
    before_action :authenticate_user!
  
    private
  
    def authorize_admin!
      authenticate_user!
      unless current_user&.admin?
        redirect_to user_session_path, alert: 'Access denied.'
      end
    end
  end
  
  
