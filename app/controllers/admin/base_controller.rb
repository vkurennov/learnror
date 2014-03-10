class Admin::BaseController < InheritedResources::Base
  before_action :authenticate_user!

  authorize_resource

  layout 'admin'
end