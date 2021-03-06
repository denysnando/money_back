# frozen_string_literal: true

class UsersController < CrudController
  before_action do
    use_klass(User)
    clean_password_fields(:user)
    set_user_type
  end

  def new
    super
  end

  protected

  def collection
    super
    @collections = @collections.where(user_type: session[:user_type])
  end

  private

  def clean_password_fields(_model)
    return unless params[:user] && params[:user][:password].blank?

    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end

  def collection_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation,
                                 :user_type)
  end

  def set_user_type
    session[:user_type] = params[:user_type] if params[:user_type]
  end
end
