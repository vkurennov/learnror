require 'acceptance/acceptance_helper'

feature "Admin can manage products", %q{
  In order to sell the products
  As an admin
  I want to be able to manage products
 } do

  let(:path) { admin_products_path }

  background do
    User.create!(email: 'admin@test.com', password: '12345678', password_confirmation: '12345678', admin: true)
    visit path
  end

  it_behaves_like "Admin accessible"


  describe 'ajax', js: true do
    background do
      sign_in_with 'admin@test.com', '12345678'
    end

    scenario 'Admin can add the product' do
      expect(page).to_not have_content 'New Product'

      within '.form' do
        fill_in 'Title', with: 'New Product'
        fill_in 'Description', with: 'New descr'
        fill_in 'Price', with: '12'
        click_on 'Save'
      end

      expect(current_path).to be_eql admin_products_path

      expect(page).to have_content('New Product')
      expect(page).to have_content('New descr')
      expect(page).to have_content('12.0')
    end

    scenario 'Admin can delete th product' do
      Product.create!(title: 'New Product', description: 'descr', price: 12)
      visit path
      expect(page).to have_content 'New Product'

      click_on 'Destroy'
      #page.driver.browser.switch_to.alert.accept
      page.driver.accept_js_confirms!

      expect(current_path).to be_eql admin_products_path
      expect(page).to_not have_content 'New Product'
    end
  end

end