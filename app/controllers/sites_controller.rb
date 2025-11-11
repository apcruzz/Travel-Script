class SitesController < ApplicationController
  allow_unauthenticated_access only: %i[ index about]

  def index
    if authenticated?
      redirect_to trips_path
    end
  end

  def about
    flash.now[:notice] = "Welcome to the About Page"
    flash.now[:alert] = "This is the About alert"
  end
end
