class Admin::UsersController < Admin::BaseController
  actions only: [:index, :show]
end