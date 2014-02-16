class LotsController < InheritedResources::Base
  respond_to :html
  actions :index, :show

  before_action :authenticate_user!
end