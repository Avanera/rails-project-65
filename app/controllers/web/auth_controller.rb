# frozen_string_literal: true

module Web
  class AuthController < Web::ApplicationController
    def callback
      @user = User.find_or_create_by(email: auth.info['email'], name: auth.info['name'])
      session[:user_id] = @user.id if @user.persisted?
      redirect_to root_path
    end

    def logout
      session[:user_id] = nil
      redirect_to root_path
    end

    private

    def auth
      request.env['omniauth.auth']
    end
  end
end
