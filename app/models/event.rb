class Event < ApplicationRecord
  belongs_to :user

  validates :title, :date, presence: true
  validates :title, uniqueness: true

  REPEATABLE_TYPE = %w[none day week month year].freeze
end
