class Task < ApplicationRecord

  validates :title, presence: true, length: {minimum: 6}
  validates :description, presence: true, length: {minimum: 6}
  validates :status, presence: true, inclusion: {in: ["to do", "in progress", "in review", "done"],
                                                 message: "%{value} not status"}

  belongs_to :project
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"
  belongs_to :assignee, class_name: "User", foreign_key: "assignee_id"
end
