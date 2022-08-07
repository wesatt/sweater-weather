# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forecast do
  it 'exists and has attributes' do
    forecast = Forecast.new(forecast_response)

    expect(forecast).to be_a(Forecast)

    current = forecast.current_formatted
    expect(current).to be_a(Hash)
    expect(current.keys).to include(
      :datetime, :sunrise, :sunset, :temperature, :feels_like,
      :humidity, :uvi, :visibility, :conditions, :icon
    )
    expect(current.keys.count).to eq(10) # checks that only the keys above are present
    expect(current[:datetime]).to be_a(String)
    expect(current[:sunrise]).to be_a(String)
    expect(current[:sunset]).to be_a(String)
    expect(current[:temperature]).to be_a(Float)
    expect(current[:feels_like]).to be_a(Float)
    expect(current[:humidity]).to be_a(Integer).or be_a(Float)
    expect(current[:uvi]).to be_a(Integer).or be_a(Float)
    expect(current[:visibility]).to be_a(Integer).or be_a(Float)
    expect(current[:conditions]).to be_a(String)
    expect(current[:icon]).to be_a(String)

    daily = forecast.daily_formatted(5)
    expect(daily).to be_a(Array)
    expect(daily.count).to eq(5)
    daily.each do |day|
      expect(day.keys).to include(
        :date, :sunrise, :sunset, :max_temp, :min_temp, :conditions, :icon
      )
      expect(day.keys.count).to eq(7) # checks that only the keys above are present
      expect(day[:date]).to be_a(String)
      expect(day[:sunrise]).to be_a(String)
      expect(day[:sunset]).to be_a(String)
      expect(day[:max_temp]).to be_a(Float)
      expect(day[:min_temp]).to be_a(Float)
      expect(day[:conditions]).to be_a(String)
      expect(day[:icon]).to be_a(String)
    end

    hourly = forecast.hourly_formatted(8)
    expect(hourly).to be_a(Array)
    expect(hourly.count).to eq(8)
    hourly.each do |hour|
      expect(hour.keys).to include(
        :time, :temperature, :conditions, :icon
      )
      expect(hour.keys.count).to eq(4) # checks that only the keys above are present
      expect(hour[:time]).to be_a(String)
      expect(hour[:temperature]).to be_a(Float)
      expect(hour[:conditions]).to be_a(String)
      expect(hour[:icon]).to be_a(String)
    end
  end
end
