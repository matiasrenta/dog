class ApiUsers::WelcomeController < ActionController::Base
  layout 'api_login_flow'
  protect_from_forgery with: :null_session

  def welcome
    if api_user_signed_in?
      sign_out(:api_user)
      #redirect_to new_user_session_path
    end
  end

  # se usa para que la app movil pueda verificar si el email y password son correctos, para luego hacer el header e ingresarlo dentro de la app movil.
  def check_credentials
    api_user = ApiUser.find_by_email params[:api_user][:email]
    if api_user && api_user.valid_password?(params[:api_user][:password])
      if api_user.confirmed_at.present?
        render :json => {data: api_user, status: :ok}
      else
        render :json => {data: api_user, status: :unprocessable_entity, errors: ['Usuario no activado. Debe confirmar su cuenta visitando el enlace enviado a su email']}
      end
    else
      render :json => {data: api_user, status: :unprocessable_entity, errors: ['Email o clave incorrectos']}
    end
  end

end
