class Permission < ActiveRecord::Base
  validates :title, :action, :subject, presence: true
end
