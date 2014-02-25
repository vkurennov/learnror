class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
    auth = session['devise.oauth']

    if auth.present?
      @user.first_name = auth[:info][:first_name]
      @user.last_name = auth[:info][:last_name]
    end
  end

  def create
    super do |resource|
      resource.create_authorization(session['devise.oauth'])
    end
  end
end