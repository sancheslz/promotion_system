require ('rails_helper')

feature('Creator can\'t approve') do

    scenario('promotions have a creator') do
        # Arrange
        creator = User.create!(
            email: 'creator@host.com',
            password: '@creator123'
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
        
        login_as creator, :scope => :user

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name

        # Assert
        within('div.container') do
            expect(page).to have_content(creator.email) 
        end
    end

    scenario('hasn\'t this option') do
        # Arrange
        creator = User.create!(
            email: 'creator@host.com',
            password: '@creator123'
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
        
        login_as creator, :scope => :user

        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name

        # Assert
        within('div.container') do
            expect(page).not_to have_link('Approve Promotion') 
        end
    end

    scenario('can approve others') do
        # Arrange
        creator = User.create!(
            email: 'creator@host.com',
            password: '@creator123'
        )

        approver = User.create!(
            email: 'approver@host.com',
            password: '@approver123'
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
        
        login_as approver, :scope => :user
        
        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name

        # Assert
        within('div.container') do
            expect(page).to have_link('Approve Promotion') 
        end
    end

    scenario('can approve once') do
        # Arrange
        creator = User.create!(
            email: 'creator@host.com',
            password: '@creator123'
        )

        approver = User.create!(
            email: 'approver@host.com',
            password: '@approver123'
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
        
        login_as approver, :scope => :user
        
        # Act
        visit root_path
        click_on 'Promotions'
        click_on promotion.name
        click_on "Approve Promotion"

        # Assert
        within('div.container') do
            expect(page).not_to have_link('Approve Promotion') 
            expect(page).to have_content('Approved Promotion') 
        end
    end

end