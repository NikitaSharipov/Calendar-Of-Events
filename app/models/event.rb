class Event < ApplicationRecord
  belongs_to :user

  validates :title, :date, presence: true

  REPEATABLE_TYPE = %w[none day week month year].freeze
end
