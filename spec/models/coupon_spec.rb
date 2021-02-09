require 'rails_helper'

describe "Coupon" do

  context "validation" do

    it "code must be unique" do
      # Arrange
      creator = User.create!(
        email: 'user@host.com',
        password: 'u1s2e3r4'
      )

      promotion = Promotion.create!(
        name: 'Black Friday',
        description: 'Super Black Friday',
        code: 'BLACK50',
        discount_rate: 50,
        coupon_quantity: 100,
        expiration_date: Time.now.strftime('%d/%m/%Y'),
        user: creator
      )

      Coupon.create!(
        code: 'BLACK50-0002',
        promotion_id: promotion.id
      )

      #  Act
      coupon = Coupon.new(
        code: 'BLACK50-0002',
        promotion_id: promotion.id
      )

      coupon.valid?
      
      # Assert
      expect(coupon.errors[:code]).to include('must be unique')
    
    end
  end
end