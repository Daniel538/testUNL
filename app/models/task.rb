class Task < ApplicationRecord

  validates :title, presence: true, length: {minimum: 6}
  validates :description, presence: true, length: {minimum: 6}
  validates :status, presence: true, inclusion: {in: ["new", "in progress", "in review", "done"],
                                                 message: "%{value} not status"}

  belongs_to :project
  belongs_to :user, foreign_key: "assignee"
  belongs_to :user, foreign_key: "created_by_id"
end
