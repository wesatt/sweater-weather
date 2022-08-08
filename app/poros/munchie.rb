# frozen_string_literal: true

class Munchie
  attr_reader :name,
              :address

  def initialize(data)
    @name = data[:name]
    @address = data[:location][:display_address].join(', ')
  end
end
