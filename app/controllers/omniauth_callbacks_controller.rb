class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :oauth_callback

  def facebook
  end

  def vkontakte
  end

  protected

  def oauth_callback
    auth = request.env['omniauth.auth']

    if signed_in?
      if current_user.add_authorization(auth)
        flash[:notice] = 'Соц. сеть успешно добавлена'
      else
        flash[:error] = 'Соц. сеть уже связана с другим аккаунтом'
      end
      redirect_to profile_path
    else
      @user = User.find_for_oauth(auth)

      if @user && @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        flash[:notice] = 'Вы успешно вошли через соц. сеть' if is_navigational_format?
      else
        flash[:notice] = "Пожалуйста, завершите регистрацию."
        session['devise.oauth'] = auth
        redirect_to new_user_registration_path
      end
    end
  end
end