class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #:confirmable

  #validates :first_name, :last_name, presence: true
end
