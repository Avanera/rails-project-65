class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  before_action :authorize_category

  def index
    @categories = Category.order(name: :asc)
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.bulletins.any?
      redirect_to admin_categories_path, alert: t('.cant_delete_category')
    elsif @category.destroy
      redirect_to admin_categories_path, notice: t('.success')
    else
      redirect_to admin_categories_path, alert: @category.errors.full_messages.to_sentence
    end
  end

  private

  def authorize_category
    authorize Category
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
