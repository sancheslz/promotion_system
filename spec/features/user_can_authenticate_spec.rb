require 'rails_helper'

feature('User with credentials') do

    scenario('see the button') do
        # Arrange
        user = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
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
            password: 'u1s2e3r4'
        )

        # Act
        visit root_path
        click_on 'Login'

        # Assert
        expect(current_path).to eq(new_user_session_path)
        expect(page).to have_button('Log in')
    end

    scenario('do login') do
        # Arrange
        user = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        # Act
        visit root_path
        click_on 'Login'
        
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on 'Log in'

        # Assert
        expect(current_path).to eq(root_path)
        expect(page).to have_content(user.email)
    end

    scenario('can logout') do
        # Arrange
        user = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        # Act
        visit root_path
        click_on 'Login'
        
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on 'Log in'

        # Assert
        expect(page).to have_content('Logout')
    end

    scenario('do logout') do
        # Arrange
        user = User.create!(
            email: 'user@host.com',
            password: 'u1s2e3r4'
        )

        # Act
        visit root_path
        click_on 'Login'
        
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on 'Log in'
        click_on 'Logout'

        # Assert
        expect(page).to have_link('Login') 
        expect(page).not_to have_content(user.email)
    end

end

feature('New user can sign up') do

    scenario('can do it') do
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_link('Register')
    end

    scenario('and see the form') do
        # Arrange

        # Act
        visit root_path
        click_on 'Register'

        # Assert
        expect(current_path).to eq(new_user_registration_path)
    end

    scenario('email can\'t be blank') do
        # Arrange

        # Act
        visit root_path
        click_on 'Register'
        fill_in "Email", with: ""
        fill_in "Password", with: "u1s2e3r4"
        fill_in "Password confirmation", with: "u1s2e3r4"
        click_on "Sign up"

        # Assert
        expect(page).to have_content('can\'t be blank') 
    end

    scenario('email must be unique') do
        # Arrange
        User.create!(
            email: 'user@host.com',
            password: 'a1b2c3d4'
        )

        # Act
        visit root_path
        click_on 'Register'
        fill_in "Email", with: "user@host.com"
        fill_in "Password", with: "u1s2e3r4"
        fill_in "Password confirmation", with: "u1s2e3r4"
        click_on "Sign up"

        # Assert
        expect(page).to have_content('has already been taken') 
    end

    scenario('register with success') do
        # Arrange

        # Act
        visit root_path
        click_on 'Register'
        fill_in "Email", with: "user@host.com"
        fill_in "Password", with: "u1s2e3r4"
        fill_in "Password confirmation", with: "u1s2e3r4"
        click_on "Sign up"

        # Assert
        expect(page).to have_link('Logout') 
    end

end