# frozen_string_literal: true

class Route
  def initialize(data)
    @data = data
  end

  # def error?
  #   if @data[:routeError]
  #     true
  #   else
  #     false
  #   end
  # end

  def time_hash
    seconds = @data[:time]
    mm, _ss = seconds.divmod(60)
    hh, mm = mm.divmod(60)
    dd, hh = hh.divmod(24)
    { days: dd, hours: hh, minutes: mm }
  end

  def travel_time
    seconds = @data[:time]
    if seconds
      time = time_hash
      days = time[:days]
      hours = time[:hours]
      minutes = time[:minutes]
      "days: #{days}, hours: #{hours}, minutes: #{minutes}"
    else
      'impossible route'
    end
  end

  # def origin_city
  #   "#{@data[:locations].first[:adminArea5]}, #{@data[:locations].first[:adminArea3]}"
  # end

  # def destination_city
  #   "#{@data[:locations].last[:adminArea5]}, #{@data[:locations].last[:adminArea3]}"
  # end

  def destination_lat
    @data[:locations].last[:latLng][:lat]
  end

  def destination_lng
    @data[:locations].last[:latLng][:lng]
  end
end
