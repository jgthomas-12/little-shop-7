class HolidayBuilder

  def self.get_next_holidays

    response = HTTParty.get("https://date.nager.at/api/v3/PublicHolidays/2023/us")

    parsed = JSON.parse(response.body, symbolize_names: true)

    holidays = parsed.map do |data|
      Holiday.new(data)
    end

    query_date = Date.today

    next_holidays = holidays.select do |holiday|

      holiday_date = Date.parse(holiday.date)
      holiday_date >= query_date
    # [holidays[0], holidays[1], holidays[2]]
    end

    next_three_holidays = next_holidays.first(3)
  end
end