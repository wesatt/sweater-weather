# frozen_string_literal: true

class MunchieSerializer
  def self.format_forecast(destination, forecast, restaurant)
    {
      data: {
        id: nil,
        type: 'munchie',
        attributes: {
          destination_city: destination,
          forecast: {
            summary: '',
            temperature: ''
          },
          restaurant: {
            name: '',
            address: ''
          }
        }
      }
    }
  end
end
