class Admin::ProductsController < Admin::BaseController
  respond_to :html
  respond_to :js, only: [:create, :destroy]

  before_action :build_resource, only: [:index, :new]
  before_action :collection, only: [:create, :destroy], if: -> { request.xhr? }

  def create
    create! do |success, failure|
      success.js { flash[:notice] = 'Js Ok!' }
      failure.js { flash[:notice] = 'Js Fail!' }
    end
  end

  def destroy
    destroy! { root_path }
  end

  private

  def build_resource_params
    [params.fetch(:product, {}).permit(:title, :description, :price, images_attributes: [:image])]
  end
end
