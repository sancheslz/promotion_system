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
        click_on 'Return'

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

feature('Admin adds promotions') do

    scenario('can register it') do
        # Arrange

        # Act
        visit root_path
        click_on 'Promotions'
        click_on 'New Promotion'
        
        # Assert
        expect(current_path).to eq(new_promotion_path)
    end

    scenario('attributes can\'t be blank') do
        # Arrange

        # Act
        visit root_path
        click_on 'Promotions'
        click_on 'New Promotion'

        fill_in 'Name', with: ''
        fill_in 'Description', with: ''
        fill_in 'Code', with: ''
        fill_in 'Discount', with: ''
        fill_in 'Quantity', with: ''
        fill_in 'Expiration', with: ''
        click_button 'Create Promotion'

        # Assert
        expect(page).to have_content("can't be blank", count: 5)

    end

    scenario('code must be unique') do
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
        click_on 'New Promotion'

        fill_in 'Name', with: 'Mega Black Friday'
        fill_in 'Description', with: 'The ultimate discount'
        fill_in 'Code', with: 'BLACK50'
        fill_in 'Discount', with: '70'
        fill_in 'Quantity', with: '100'
        fill_in 'Expiration', with: Time.now.strftime('%d/%m/%Y')
        click_button 'Create Promotion'
        
        # Assert
        expect(page).to have_content('code must be unique')

    end

    scenario('successfully') do
        # Arrange

        # Act
        visit root_path
        click_on 'Promotions'
        click_on 'New Promotion'

        fill_in 'Name', with: 'Mega Black Friday'
        fill_in 'Description', with: 'The ultimate discount'
        fill_in 'Code', with: 'BLACK50'
        fill_in 'Discount', with: '70'
        fill_in 'Quantity', with: '100'
        fill_in 'Expiration', with: Time.now.strftime('%d/%m/%Y')
        click_button 'Create Promotion'
        
        promotion = Promotion.last

        # Assert
        expect(current_path).to be(promotion_path(promotion))

    end

    scenario('can cancel the operation') do
        # Arrange

        # Act
        visit root_path
        click_on 'Promotions'
        click_on 'New Promotion'
        click_on 'Cancel'
        
        # Assert
        expect(current_path).to be(promotions_path)

    end
    
end