class SitesController < ApplicationController
  def index
  end

  def about
    flash.now[:notice] = "Welcome to the About Page"
    flash.now[:alert] = "This is the About alert"
  end
end
