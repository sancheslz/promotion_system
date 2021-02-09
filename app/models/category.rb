class Category < ApplicationRecord
    validates :name, :code, presence: true
    validates :code, uniqueness: { message: 'must be unique' }

end
