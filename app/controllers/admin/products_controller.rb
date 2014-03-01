class Admin::ProductsController < Admin::BaseController
  respond_to :html
  respond_to :js, only: [:create, :destroy]

  before_action :build_resource, only: [:index, :new]
  before_action :collection, only: [:create, :destroy], if: -> { request.xhr? }



  private

  def build_resource_params
    [params.fetch(:product, {}).permit(:title, :description, :price, images_attributes: [:image])]
  end
end
