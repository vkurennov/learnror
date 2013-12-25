class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  layout 'admin'

  protected

  def check_admin
    render text: "У вас нет прав доступа к этой странице" unless current_user.admin?
    false
  end
end