class ApplicationController < ActionController::Base
    before_action :authenticate_user!
  
    private
  
    def authorize_admin!
      authenticate_user!
      unless current_user&.admin?
        redirect_to root_path, alert: 'Access denied.'
      end
    end
  
    def after_sign_in_path_for(resource)
      if resource.user_type == 'trader'
        trader_home_path
      elsif resource.user_type = 'admin'
        admin_users_path  
      else
        root_path
      end
    end
end