require 'spec_helper'

feature "Admin can manage categories", %q{
  In order to group products by categories
  As an admin
  I want to be able to manage categories
 } do

  let(:path) { admin_categories_path }

  background do
    User.create!(email: 'admin@test.com', password: '12345678', password_confirmation: '12345678', admin: true)
  end

  it_behaves_like "Admin accessible"

  scenario 'Admin can view categroies list' do
    visit path
  end

end