require 'rails_helper'

feature('Admin can see promotions') do

    scenario('successfully') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )

        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'

        # Assert

        expect(page).to have_content(promotion.name)
    end

    scenario('with its details') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )

        # Act
        login_as creator, :scope => :user
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
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )

        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Return'

        # Assert
        expect(current_path).to eq(promotions_path) 
    end
    
    scenario('and returns to homepage') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )

        # Act
        login_as creator, :scope => :user
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
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )


        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'

        # Assert
        expect(page).to have_content('No promotions founded')
    end
    
end

feature('Admin adds promotions') do

    scenario('can register it') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )


        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on 'New Promotion'
        
        # Assert
        expect(current_path).to eq(new_promotion_path)
    end

    scenario('attributes can\'t be blank') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )


        # Act
        login_as creator, :scope => :user
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
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )

        # Act
        login_as creator, :scope => :user
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
        expect(page).to have_content('Code must be unique')

    end

    scenario('successfully') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )


        # Act
        login_as creator, :scope => :user
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
        expect(current_path).to eq(promotion_path(promotion))

    end

    scenario('can cancel the operation') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )


        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on 'New Promotion'
        click_on 'Cancel'
        
        # Assert
        expect(current_path).to eq(promotions_path)

    end

end

feature('Admin edits a promotion') do
    
    scenario('can do it') do
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
        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Edit Promotion'
        
        # Assert
        expect(current_path).to eq(edit_promotion_path(promotion))
    end

    scenario('can\'t let blanked field') do
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
        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Edit Promotion'

        fill_in 'Name', with: ''
        fill_in 'Description', with: ''
        fill_in 'Code', with: ''
        fill_in 'Discount', with: ''
        fill_in 'Quantity', with: ''
        fill_in 'Expiration', with: ''
        click_button 'Update Promotion'

        # Assert
        expect(page).to have_content('can\'t be blank', count: 5)
    end

    scenario('neither uses an existing code') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )
        promotion = Promotion.create!(
            name: 'Super Black Friday',
            description: 'Amazing Black Friday',
            code: 'SBLACK',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )
        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Edit Promotion'

        fill_in 'Code', with: 'BLACK50'
        click_on 'Update Promotion'

        # Assert
        expect(page).to have_content('must be unique')
    end

    scenario('sees the promotion edited') do
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
        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Edit Promotion'

        fill_in 'Name', with: 'Super Black Friday'
        click_on 'Update Promotion'

        # Assert
        expect(current_path).to eq(promotion_path(promotion))
        expect(page).to have_content(promotion.reload.name)
        expect(page).to have_content(promotion.reload.code)
    end

    scenario('can cancel the operation') do
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
        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Edit Promotion'

        # Assert
        fill_in 'Name', with: 'Super Black Friday'
        click_on 'Cancel'

        # Assert
        expect(current_path).to eq(promotion_path(promotion))
        expect(page).to have_content(promotion.name)

    end

end

feature('Admin deletes a promotion') do
    
    scenario('can do it') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )

        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on promotion.name

        # Assert
        expect(page).to have_link('Delete Promotion')
    end

    scenario('have an alert message') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )

        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Delete Promotion'

        # Assert
        expect(page).to have_content('Do you really want to delete this promotion?')
    end

    scenario('delete successfully') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )

        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Delete Promotion'
        click_on 'Confirm'

        # Assert
        expect(current_path).to eq(promotions_path)
        expect(page).not_to have_content(promotion.name)
    end

    scenario('can cancel the operation') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super promotion of Black Friday',
            code: 'BLACK50',
            discount_rate: '50',
            coupon_quantity: '100',
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )

        # Act
        login_as creator, :scope => :user
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on 'Delete Promotion'
        click_on 'Cancel'

        # Assert
        expect(current_path).to eq(promotion_path(promotion))
    end

end