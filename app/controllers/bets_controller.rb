class BetsController < InheritedResources::Base
  belongs_to :lot

  respond_to :js
  actions :create

  def create
    create! do |success, failure|
      success.js do
        PrivatePub.publish_to '/lots/update', lot_id: resource.lot.id, end_time: resource.lot.end_time.to_s
        render nothing: true
      end
    end
  end
end