require 'rails_helper'

describe "Category" do
  
  context "validation" do

    it "fiels can't be blank" do
      # Arrange
      category = Category.new

      # Act
      category.valid?

      # Assert
      expect(category.errors[:name]).to include('can\'t be blank')
      expect(category.errors[:code]).to include('can\'t be blank')
    end

    it "code must be unique" do
      # Arrange
      Category.create!(
        name: 'Electronics',
        code: 'ELEKTRO'
      )

      # Act
      category = Category.new(
        name: 'Computers',
        code: 'ELEKTRO'
      )
      category.valid?

      # Assert
      expect(category.errors[:code]).to include('must be unique')
    end
    
  end
  
end