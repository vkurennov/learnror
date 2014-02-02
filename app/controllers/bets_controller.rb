class BetsController < InheritedResources::Base
  belongs_to :lot

  respond_to :js
  actions :create
end