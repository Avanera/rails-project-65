class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    filter = validated_filter
    @bulletins = Bulletin.send(filter).order(created_at: :desc)
  end

  def archive
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.archive!
      redirect_to admin_path, notice: t('.success')
    else
      redirect_to admin_path, notice: t('.failure')
    end
  end

  def publish
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.publish!
      redirect_to admin_path, notice: t('.success')
    else
      redirect_to admin_path, notice: t('.failure')
    end
  end

  def reject
    @bulletin = Bulletin.find(params[:id])
    if @bulletin.reject!
      redirect_to admin_path, notice: t('.success')
    else
      redirect_to admin_path, notice: t('.failure')
    end
  end

  private

  def validated_filter
    permitted_values = [ 'all', 'under_moderation' ]

    if permitted_values.include?(params[:filter])
      params[:filter]
    else
      'under_moderation'
    end
  end
end
