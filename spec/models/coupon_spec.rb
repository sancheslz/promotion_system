require 'rails_helper'

describe "Coupon" do

  context "validation" do

    it "code must be unique" do
      # Arrange
      promotion = Promotion.create!(
        name: 'Black Friday',
        description: 'Super Black Friday',
        code: 'BLACK50',
        discount_rate: 50,
        coupon_quantity: 100,
        expiration_date: Time.now.strftime('%d/%m/%Y')
      )

      #  Act
      coupon = Coupon.create!(
        code: 'BLACK50-0002',
        promotion_id: promotion.id
      )

      coupon.valid?
      
      # Assert
      expect(coupon.errors[:code]).to include('must be unique')
    
    end
  end
end