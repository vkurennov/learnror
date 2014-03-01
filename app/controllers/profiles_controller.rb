class ProfilesController < ApplicationController
  before_action :authenticate_user!

  before_action :authorize_resource

  def show
  end

  private

  def authorize_resource
    authorize! :manage, :profile
  end
end