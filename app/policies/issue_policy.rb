class IssuePolicy < TaskPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
