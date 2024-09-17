# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @bulletins = current_user.bulletins.order(created_at: :desc)
  end
end
