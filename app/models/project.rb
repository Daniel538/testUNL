class Project < ApplicationRecord
  paginates_per 9

  validates :name, presence: true, length: {minimum: 5}
  validates :summary, presence: true, length: {minimum: 20}

  validates_date :end_date, after: :start_date

  has_many :tasks, dependent: :destroy

end
