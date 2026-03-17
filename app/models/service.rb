class Service < ApplicationRecord
  has_many :user_services, dependent: :destroy
  has_many :users, through: :user_services
end
