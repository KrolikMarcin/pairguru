class UsersController < ApplicationController
  def best_commenters
    @commenters = User.best_commenters
  end
end
