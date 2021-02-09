require 'rails_helper'

feature('Admin search for promotions') do
    
    scenario('can search') do
        # Arrange
        creator = User.create!(
            email: 'creator@host.com',
            password: 'user123'
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

        # Act
        login_as creator, :scope => :user 
        visit root_path 

        # Assert
        expect(page).to have_content('Search Promotions')
    end

    scenario('with success') do
        # Arrange
        creator = User.create!(
            email: 'creator@host.com',
            password: 'user123'
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

        # Act
        login_as creator, :scope => :user 
        visit root_path 
        fill_in 'Search Promotions', with: 'Friday'
        click_on 'Search'

        # Assert
        expect(page).to have_content(promotion.name)
    end

    scenario('without success') do
        # Arrange
        creator = User.create!(
            email: 'creator@host.com',
            password: 'user123'
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

        # Act
        login_as creator, :scope => :user 
        visit root_path 
        fill_in 'Search Promotions', with: 'Mondey'
        click_on 'Search'

        # Assert
        expect(page).not_to have_content(promotion.name)
        expect(page).to have_content('No promotions founded')
    end

end