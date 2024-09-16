# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def new?
    user
  end

  def create?
    new?
  end

  def edit?
    admin? || author?
  end

  def update?
    edit?
  end

  private

  def author?
    record.author == user
  end

  def admin?
    user&.admin?
  end
end
