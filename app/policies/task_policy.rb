class TaskPolicy < ProjectPolicy

  def update?
    user.present?
  end

  def edit?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
