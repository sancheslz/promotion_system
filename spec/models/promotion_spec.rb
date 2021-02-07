require 'rails_helper'

describe "Promotion" do

  context "validation" do

    it "fields can't be blank" do
      # Arrange
      promotion = Promotion.new

      # Act
      promotion.valid?

      # Assert
      expect(promotion.errors[:name]).to include("can't be blank") 
      expect(promotion.errors[:description]).not_to include("can't be blank") 
      expect(promotion.errors[:code]).to include("can't be blank") 
      expect(promotion.errors[:discount_rate]).to include("can't be blank") 
      expect(promotion.errors[:coupon_quantity]).to include("can't be blank") 
      expect(promotion.errors[:expiration_date]).to include("can't be blank") 

    end

    it "code must be unique" do
      # Arrange 
      Promotion.create!(
        name: 'Black Friday',
        description: '',
        code: 'BLACK50',
        discount_rate: 50,
        coupon_quantity: 100,
        expiration_date: Time.now.strftime('%d/%m/%Y')
      )

      # Act
      promotion = Promotion.new(
        name: 'Thanks Given',
        description: '',
        code: 'BLACK50',
        discount_rate: 50,
        coupon_quantity: 100,
        expiration_date: Time.now.strftime('%d/%m/%Y')
      )
      promotion.valid?

      # Assert
      expect(promotion.errors[:code]).to include('must be unique')
      
    end
    
  end
  
end