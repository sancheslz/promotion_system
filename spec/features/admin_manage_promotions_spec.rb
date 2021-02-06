require 'rails_helper'

feature('Admin can see promotions') do

    scenario('successfully') do
        # Arrange
        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
        )

        # Act
        visit root_path
        click_on 'Promotions'

        # Assert
        expect(page).to have_content(promotion.name)
    end

    scenario('with its details') do
        # Arrange
        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
        )

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name

        # Assert
        expect(page).to have_content(promotion.name)
        expect(page).to have_content(promotion.description)
        expect(page).to have_content(promotion.code)
        expect(page).to have_content(promotion.discount_rate)
        expect(page).to have_content(promotion.coupon_quantity)
        expect(page).to have_content(promotion.expiration_date)
    end
    
    scenario('and returns to promotions page') do
        # Arrange
        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
        )

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_om 'Return'

        # Assert
        expect(current_path).to eq(promotions_path) 
    end
    
    scenario('and returns to homepage') do
        # Arrange
        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
        )

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Return'
        click_on 'Home'

        # Assert
        expect(current_path).to eq(root_path) 
    end
    
    scenario('or a message if no promotions') do
        # Arrange

        # Act
        visit root_path
        click_on 'Promotions'

        # Assert
        expect(page).to have_content('No promotions founded')
    end
    
end
