# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update to_moderation archive]

  def index
    @bulletins = Bulletin.order(created_at: :desc)
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = current_user.bulletins.build
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
      if @bulletin.save
        redirect_to root_path, notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        render :new, status: :unprocessable_entity
      end
  end

  def update
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.update(bulletin_params)
      redirect_to root_path, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderation
  end

  def archive
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
