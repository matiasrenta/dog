class V2::BaseController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :restrict_applications_access
  before_action :authenticate_user_or_api_user_or_social_user, unless: :access_only_with_token?
  before_action :check_if_api_user_active, unless: :access_only_with_token?
  #before_action :set_user_time_zone


  def user_for_paper_trail
    nil # disable whodunnit tracking for paper_trail. Para que no aparezca el warning
  end

  protected

  def set_user_time_zone
    Time.zone = current_user.time_zone if user_signed_in?
  end

  # metodo conveniente para obtener el usuario que hizo el requerimiento a la api
  def current_user
    @user || @api_user || @social_user
  end

  private

  def restrict_applications_access
    @api_key = ApiKey.find_by_access_token(request.headers['HTTP_ACCESS_TOKEN']) # el header original es 'access_token', pero rails 4 lo transforma a HTTP_ACCES_TOKEN (uppercase, underscore and prefixed with HTTP)
    head :unauthorized unless @api_key
  end

  def authenticate_user_or_api_user_or_social_user
    if request.headers['HTTP_AUTHORIZATION'].present?
      authenticate_user_or_api_user
    elsif request.headers['HTTP_SOCIAL_USER'].present?
      authenticate_social_user
    else
      head :unauthorized
    end
  end

  def authenticate_user_or_api_user
    # users or api_user are authenticated with http basic auth
    authenticate_with_http_basic do |username, password|
      user = User.find_by_email username
      if user && user.valid_password?(password)
        @user = user
        return true
      end
      api_user = ApiUser.find_by_email username
      if api_user && api_user.valid_password?(password)
        @api_user = api_user
        return true
      end
      head :unauthorized
    end
  end

  def authenticate_social_user
    # aqui solo debo ver si existe el provider/uid. Si no existe lo agrego.
    # Al no haber password, se debe confiar que la application (por ejemplo una aplicacion movil)
    # haya hecho el login con el provider correctamente. Por eso es importante primero validar la ApiKey, sino cualquiera
    # podria entrar pasando un provider/uid inventado o peor aun el de otra persona.
    # La otra es que con el access token que me llega, llamar al endpoint de facebook: https://graph.facebook.com/me?access_token=" .$access_token
    # el cual me devuelve la hash del usuario. Por ahora no uso el access_token.
    social_user_header = ActiveSupport::JSON.decode(request.headers['HTTP_SOCIAL_USER'])
    head :unauthorized unless social_user_header['provider'].present? && social_user_header['uid'].present?

    logger.fatal "social_user_header['provider']: #{social_user_header['provider']}"
    logger.fatal "social_user_header['uid']: #{social_user_header['uid']}"
    logger.fatal "social_user_header['access_token']: #{social_user_header['access_token']}"
    logger.fatal "social_user_header['info']: #{social_user_header['info']}"
    logger.fatal "social_user_header['info']['email']: #{social_user_header['info']['email']}"



    @social_user = SocialUser.find_by(provider: social_user_header['provider'], uid: social_user_header['uid'])
    unless @social_user
      @social_user = SocialUser.create(provider: social_user_header['provider'],
                                       uid: social_user_header['uid'],
                                       access_token: social_user_header['access_token'],
                                       email: social_user_header['info'] ? social_user_header['info']['email'] : nil,
                                       json_data: request.headers['HTTP_SOCIAL_USER'])
      head :unauthorized unless (@social_user && @social_user.errors.empty?)
    end
  end

  def check_if_api_user_active
    if @api_user && @api_user.confirmed_at.blank?
      render :json => {data: @api_user, status: :unprocessable_entity, errors: ['Usuario no activado. Debe confirmar su cuenta visitando el enlace enviado a su email.']}
    end
  end

  def access_only_with_token?
    @api_key.access_only_with_token
  end

end
