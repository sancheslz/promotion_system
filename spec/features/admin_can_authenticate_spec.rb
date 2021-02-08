require 'rails_helper'

feature('User with credentials') do

    scenario('see the button') do
        # Arrange
        user = User.create!(
            email: 'user@host.com',
            passwd: 'u1s2e3r4'
        )

        # Act
        visit root_path

        # Assert
        expect(page).to have_link('Login')
    end

    scenario('can login') do
        # Arrange
        user = User.create!(
            email: 'user@host.com',
            passwd: 'u1s2e3r4'
        )

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq(new_user_session_path)
        expect(page).to have_button('Enter')
    end

    scenario('do login') do
        # Arrange
        user = User.create!(
            email: 'user@host.com',
            passwd: 'u1s2e3r4'
        )

        # Act
        visit root_path
        click_on 'Login'
        
        fill_in 'E-mail', user.email
        fill_in 'Password', user.passwd
        click_on 'Enter'

        # Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content(user.email)
    end

    scenario('can logout') do
        # Arrange
        user = User.create!(
            email: 'user@host.com',
            passwd: 'u1s2e3r4'
        )
        sign_in user

        # Act
        visit root_path

        # Assert
        expect(page).to have_content('Logout')
    end

    scenario('do logout') do
        # Arrange
        user = User.create!(
            email: 'user@host.com',
            passwd: 'u1s2e3r4'
        )
        sign_in user

        # Act
        visit root_path
        click_on 'Logout'

        # Assert
        expect(page).to have_link('Login') 
        expect(page).not_to have_content(user.email)
    end

end