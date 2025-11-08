class UsersController < ApplicationController
  alllow_unauthenticated_access only: %i[ new create]
  def new
  end
end
