class Task < ApplicationRecord
  has_rich_text :description
  validates :title, presence: true
  enum :status, { to_do: 0, in_progress: 1, done: 2 }
  enum :priority, { low: 0, medium: 1, high: 2 }
end
