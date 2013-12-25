require 'spec_helper'

feature "Admin logging in to admin area", %q{
  In order to manage auction's settings
  As an admin
  I want to logging into admin area
 } do

  background do
    visit admin_products_path
  end

  context 'Admin' do
    background do
      User.create!(email: 'admin@test.com', password: '12345678', password_confirmation: '12345678', admin: true)
    end

    scenario "Unauthenticated user tries to get an access to admin area" do
      current_path.should == new_user_session_path
      page.should have_content 'Вам необходимо войти или зарегистрироваться'
    end

    scenario "Admin successfully logging into admin area" do
      sign_in_with 'admin@test.com', '12345678'

      page.should have_content 'Список продуктов'
    end

    scenario "User fill in wrong credentials" do
      sign_in_with 'wrong', 'wrong'

      current_path.should == new_user_session_path
      page.should have_content 'Неверное имя пользователя или пароль'
    end
  end

  scenario "Non-admin user tries to log in" do
    User.create!(email: 'user@test.com', password: '12345678', password_confirmation: '12345678', admin: false)

    sign_in_with 'user@test.com', '12345678'

    page.should have_content "У вас нет прав доступа к этой странице"
  end
end