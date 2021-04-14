class ReceiverPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    return true
  end

  def update?
    record.poll.user == user
  end

  def destroy?
    record.poll.user == user
  end
end
