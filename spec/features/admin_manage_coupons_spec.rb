require 'rails_helper'

feature('Admin generates coupons') do

    scenario('can do it') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

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
        visit root_path
        click_on 'Promotions'
        click_on promotion.name

        # Assert
        expect(page).to have_link('Generate Coupons')
    end
    
    scenario('with success') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator,
            approved: true
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
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator,
            approved: true
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
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator,
            approved: true
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
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 100,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator,
            approved: true
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

feature('Admin inactivate coupons') do

    scenario('can do it') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 10,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )
        
        coupon = Coupon.create!(
            code: 'BLACK50-0001',
            promotion: promotion
        )

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name 

        # Assert
        within("#coupon_code_#{coupon.id}") do
            expect(page).to have_link('Inactivate')
        end
    end

    scenario('with success') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 10,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )
        
        coupon = Coupon.create!(
            code: 'BLACK50-0001',
            promotion: promotion
        )

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name 
        click_on 'Generate Coupons'
        click_on 'Inactivate'

        # Assert
        expect(page).to have_content("#{coupon.code} (Inactive)")
    end

    scenario('can\'t inactivate again') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 10,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )
        
        coupon = Coupon.create!(
            code: 'BLACK50-0001',
            promotion: promotion
        )

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name 
        click_on 'Generate Coupons'
        click_on 'Inactivate'

        # Assert
        within("#coupon_code_#{coupon.id}") do
            expect(page).not_to have_link('Inactivate')
        end
    end

end

feature('Admin reactivate coupons') do
    
    scenario('can do it') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 10,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )
        
        coupon = Coupon.create!(
            code: 'BLACK50-0001',
            promotion: promotion
        )

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name 
        within("#coupon_code_#{coupon.id}") do
            click_on "Inactivate"
        end

        # Assert
        within("#coupon_code_#{coupon.id}") do
            expect(page).to have_link('Activate')
        end
    end
    
    scenario('with success') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 10,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )
        
        coupon = Coupon.create!(
            code: 'BLACK50-0001',
            promotion: promotion
        )

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name 
        within("#coupon_code_#{coupon.id}") do
            click_on "Inactivate"
            click_on 'Activate'
        end

        # Assert
        within("#coupon_code_#{coupon.id}") do
            expect(page).not_to have_content('Inactive') 
        end
    end
    
    scenario('can\'t activate again') do
        # Arrange
        creator = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        login_as creator, :scope => :user

        promotion = Promotion.create!(
            name: 'Black Friday',
            description: 'Super Black Friday',
            code: 'BLACK50',
            discount_rate: 50,
            coupon_quantity: 10,
            expiration_date: Time.now.strftime('%d/%m/%Y'),
            user: creator
        )
        
        coupon = Coupon.create!(
            code: 'BLACK50-0001',
            promotion: promotion
        )

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name 
        within("#coupon_code_#{coupon.id}") do
            click_on "Inactivate"
            click_on 'Activate'
        end

        # Assert
        within("#coupon_code_#{coupon.id}") do
            expect(page).not_to have_link('Activate')
        end
    end

end