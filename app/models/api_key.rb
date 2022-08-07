class ApiKey < ApplicationRecord
  belongs_to :user

  validates :token, uniqueness: true, presence: true
end
