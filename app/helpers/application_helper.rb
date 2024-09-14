module ApplicationHelper
  def assign_provider
    if Rails.env == 'development'
      provider = 'developer'
    else
      provider = 'github'
    end
  end
end
