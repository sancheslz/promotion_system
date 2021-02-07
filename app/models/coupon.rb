class Coupon < ApplicationRecord
  belongs_to :promotion

  validates :code, uniqueness: { message: 'must be unique' } 
  enum status: { active: 0, inactive: 10 }
end
