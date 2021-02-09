require 'rails_helper'

feature('Admin sees registered categories') do

    scenario('can do it') do
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_link('Categories')
    end

    scenario('have records') do
        # Arrange
        category = Category.create!(
            name: 'Electronics',
            code: 'ELEKTON'
        )

        # Act
        visit root_path
        click_on 'Categories'

        # Assert
        expect(page).to have_content(category.name) 
        expect(page).to have_content(category.code) 
    end

    scenario('haven\'t records') do
        # Arrange

        # Act
        visit root_path
        click_on 'Categories'

        # Assert
        expect(page).to have_content('No records') 
    end

end


feature('Admin registers a category') do

    scenario('can do it') do
        # Arrange

        # Act
        visit root_path
        click_on 'Categories'

        # Assert
        expect(page).to have_link('New Category') 
    end

    scenario('in a form') do
        # Arrange

        # Act
        visit root_path
        click_on 'Categories'
        click_on 'New Category'

        # Assert
        expect(current_path).to eq(new_category_path)
    end
    
    scenario('fields can\'t be blank') do
        # Arrange

        # Act
        visit root_path
        click_on 'Categories'
        click_on 'New Category'

        fill_in 'Name', with: ''
        fill_in 'Code', with: ''
        click_on 'Create Category'
        
        # Assert
        expect(page).to have_content('can\'t be blank') 
    end
    
    scenario('code must be unique') do
        # Arrange
        category = Category.create!(
            name: 'Electronics',
            code: 'ELEKTON'
        )

        # Act
        visit root_path
        click_on 'Categories'
        click_on 'New Category'

        fill_in 'Name', with: 'Computers'
        fill_in 'Code', with: 'ELEKTON'
        click_on 'Create Category'

        # Assert
        expect(page).to have_content('must be unique') 
    end
    
    scenario('with success') do
        # Arrange

        # Act
        visit root_path
        click_on 'Categories'
        click_on 'New Category'

        fill_in 'Name', with: 'Electronics'
        fill_in 'Code', with: 'ELEKTON'
        click_on 'Create Category'

        # Assert
        category = Category.last
        expect(page).to have_content(category.name)
        expect(page).to have_content(category.code)
    end
    
    scenario('can cancel the operation') do
        # Arrange

        # Act
        visit root_path
        click_on 'Categories'
        click_on 'New Category'
        click_on 'Cancel'
        
        # Assert
        expect(current_path).to eq(categories_path) 
    end

end

feature('Admin edits a category') do

    scenario('can do it') do
        # Arrange
        category = Category.create!(
            name: 'Electronics',
            code: 'ELEKTON'
        )

        # Act
        visit root_path
        click_on 'Categories'
        click_on category.name 

        # Assert
        expect(page).to have_link('Edit Category') 
    end
    
    scenario('fields can\'t be blank') do
        # Arrange
        category = Category.create!(
            name: 'Electronics',
            code: 'ELEKTON'
        )

        # Act
        visit root_path
        click_on 'Categories'
        click_on category.name 
        click_on 'Edit Category'

        fill_in 'Name', with: ''
        fill_in 'Code', with: ''
        click_on 'Update Category'

        # Assert
        expect(page).to have_content('can\'t be blank') 
    end
    
    scenario('code must be unique') do
        # Arrange
        Category.create!(
            name: 'Electronics',
            code: 'ELEKTON'
        )

        category = Category.create!(
            name: 'Computers',
            code: 'COMPTER'
        )

        # Act
        visit root_path
        click_on 'Categories'
        click_on category.name 
        click_on 'Edit Category'

        fill_in 'Name', with: 'Computers'
        fill_in 'Code', with: 'ELEKTON'
        click_on 'Update Category'

        # Assert
        expect(page).to have_content('must be unique') 
    end
    
    scenario('with success') do
        # Arrange
        category = Category.create!(
            name: 'Electronics',
            code: 'ELEKTON'
        )

        # Act
        visit root_path
        click_on 'Categories'
        click_on category.name 
        click_on 'Edit Category'

        fill_in 'Name', with: 'Computers'
        fill_in 'Code', with: 'COMPTER'
        click_on 'Update Category'

        # Assert
        category = Category.last
        expect(page).to have_content(category.name) 
        expect(page).to have_content(category.code) 
    end
    
    scenario('can cancel the operation') do
        # Arrange
        category = Category.create!(
            name: 'Electronics',
            code: 'ELEKTON'
        )

        # Act
        visit root_path
        click_on 'Categories'
        click_on category.name 
        click_on 'Edit Category'
        click_on 'Cancel'

        # Assert
        expect(current_path).to eq(categories_path) 
    end

end