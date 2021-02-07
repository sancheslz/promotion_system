require 'rails_helper'

feature('Admin generates coupons') do
    
    scenario('can do it') do
        # Arrange
        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y')
        )
        
        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name

        # Assert
        expect(page).to have_link('Generate Coupons')
    end
    
    scenario('with success') do
        # Arrange
        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y')
        )
        
        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Generate Coupons'

        # Assert
        expect(page).to have_content('Coupons generated with success')
        expect(page).to have_content("#{promotion.code}-0001")
        expect(page).to have_content("#{promotion.code}-0100")
        expect(page).not_to have_content("#{promotion.code}-0101")
        expect(page).to have_content("#{promotion.code}-", count: promotion.coupon_quantity)
    end
    
    scenario('can\'t generate again') do
        # Arrange
        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y')
        )
        promotion.generate_coupons!
        
        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Generate Coupons'

        # Assert
        expect(page).to have_content('Can\'t generate again') 
        expect(page).to have_content("#{promotion.code}-", count: promotion.coupon_quantity)
    end
    
    scenario('neither change the Promotion code') do
        # Arrange
        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y')
        )
        promotion.generate_coupons!
        
        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Edit Promotion'
        
        fill_in 'Code', with: 'BLACK70'
        click_on 'Update Promotion'

        # Assert
        expect(page).to have_content('can\'t change the code')
    end
    
    scenario('neither change the Promotion quantity') do
        # Arrange
        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y')
        )
        promotion.generate_coupons!
        
        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Edit Promotion'
        
        fill_in 'Quantity', with: '20'
        click_on 'Update Promotion'

        # Assert
        expect(page).to have_content('can\'t change the quantity')
    end

end