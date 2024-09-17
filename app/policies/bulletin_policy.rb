# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if !user
        scope.published
      elsif user.admin?
        scope.all
      else
        scope.published_or_created_by(user)
      end
    end

    private

    attr_reader :user, :scope
  end

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
