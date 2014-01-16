shared_examples_for "Admin accessible" do
  background do
    visit path
  end

  scenario 'Admin tries to get an access' do
    sign_in_with 'admin@test.com', '12345678'
    page.should_not have_content "У вас нет прав доступа к этой странице"
    current_path.should_not == new_user_session_path
  end

  scenario 'Non-admin user tries to get access' do
    User.create!(email: 'user@test.com', password: '12345678', password_confirmation: '12345678', admin: false)
    sign_in_with 'user@test.com', '12345678'
    page.should have_content "У вас нет прав доступа к этой странице"
  end
end