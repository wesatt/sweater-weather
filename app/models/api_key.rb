# frozen_string_literal: true

class ApiKey < ApplicationRecord
  belongs_to :user

  validates :token, uniqueness: true, presence: true
end
