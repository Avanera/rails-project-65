# frozen_string_literal: true

class Web::ProfileController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @q = current_user.bulletins.ransack(params[:q])
    @q.sorts = 'created_at desc'
    @bulletins = @q.result.page(params[:page])
  end
end
