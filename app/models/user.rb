# frozen_string_literal: true

class User < ApplicationRecord
  has_many :api_keys

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password

  has_secure_password
end
