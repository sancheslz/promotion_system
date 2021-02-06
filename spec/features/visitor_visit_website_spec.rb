require 'rails_helper'

feature('Visitor visits website') do
    scenario "with success" do
        # Arrange

        # Act
        visit root_path 

        # Assert
        expect(page).to have_content('PromotionSystem')
        expect(page).to have_content('Welcome to the Promotion Management System')
    end
end