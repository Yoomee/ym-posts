class UsersController < ApplicationController
  include YmUsers::UsersController
  load_and_authorize_resource

  private
  def permitted_user_parameters
    %w(bio email first_name image last_name remove_image retained_image)
  end

end
