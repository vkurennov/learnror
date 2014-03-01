class Admin::CategoriesController < Admin::BaseController
  respond_to :html


  private

  def build_resource_params
    [params.fetch(:category, {}).permit(:title)]
  end
end
