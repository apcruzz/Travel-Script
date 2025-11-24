class ApplicationController < ActionController::Base
  include Authentication
  before_action :resume_session
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_current_user

  helper_method :hide_navbar?

    def hide_navbar?
    # Hide navbar on the landing page + login page + login error
    (
      (controller_name == "sites" && action_name == "index") ||
      (controller_name == "sessions" && action_name.in?([ "new", "create" ]))
    ) && !authenticated?
    end

  private

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end
end
