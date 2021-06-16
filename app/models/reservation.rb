# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :screening
  belongs_to :ticket_desk, optional: true
  belongs_to :user
  has_many :tickets, dependent: :destroy

  validates :status, presence: true, inclusion: { in: %w[confirmed paid], message: '%{status} is not a valid status' }
end
