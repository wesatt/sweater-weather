# frozen_string_literal: true

class MunchieSerializer
  def self.format_munchie(destination, forecast, restaurant)
    {
      data: {
        id: nil,
        type: 'munchie',
        attributes: {
          destination_city: destination,
          forecast: {
            summary: forecast[:conditions],
            temperature: forecast[:temperature].to_f
          },
          restaurant: {
            name: restaurant.name,
            address: restaurant.address
          }
        }
      }
    }
  end
end
