class Coupon < ApplicationRecord
  belongs_to :promotion

  validates :code, uniqueness: { message: 'must be unique' } 
end
