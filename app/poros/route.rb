# frozen_string_literal: true

class Route
  attr_reader :distance

  def initialize(data)
    @data = data
  end

  def time_hash
    seconds = @data[:time]
    if seconds
      mm, ss = seconds.divmod(60)
      hh, mm = mm.divmod(60)
      dd, hh = hh.divmod(24)
      { days: dd, hours: hh, minutes: mm }
    else
      'impossible route'
    end
  end

  def travel_time
    time = time_hash
    days = time[:days]
    hours = time[:hours]
    minutes = time[:minutes]
    "days: #{days}, hours: #{hours}, minutes: #{minutes}"
  end
end
