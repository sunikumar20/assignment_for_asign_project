class UsersController < ApplicationController
  autocomplete :user, :email
end
