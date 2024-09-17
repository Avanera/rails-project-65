# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update to_moderate archive]

  def index
    @bulletins = Bulletin.published.order(created_at: :desc)
  end

  def show
    @bulletin = policy_scope(Bulletin).find(params[:id])
  end

  def new
    @bulletin = current_user.bulletins.build
    authorize @bulletin
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin
  end

  def create
    @bulletin = current_user.bulletins.build(bulletin_params)
    authorize @bulletin
    if @bulletin.save
      redirect_to @bulletin, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    authorize @bulletin

    if @bulletin.update(bulletin_params)
      redirect_to @bulletin, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderate
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.to_moderate!
      redirect_to profile_path, notice: t('.success')
    else
      redirect_to profile_path, notice: t('.failure')
    end
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.archive!
      redirect_to profile_path, notice: t('.success')
    else
      redirect_to profile_path, notice: t('.failure')
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :category_id, :image)
  end
end
