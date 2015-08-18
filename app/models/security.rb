class Security < ActiveRecord::Base
	has_many :quotes

	def default_period
		"5"
	end

  def five_day_moving_average(period:)
  	p = Period.find_by(symbol: period)
  	periods_needed = (390 / p[:time_in_mins]) * 5
		
		quotes_close = quotes.select(:close).where("period = \"period\"").order(time: :desc).limit(periods_needed)
		
    quotes_close.map { |q| q[:close] }.reduce(:+) / quotes_close.count
  end

  def price_over_five_day_moving_average?
  	last_price > five_day_moving_average(period: default_period)
  end

  def last_price
    quotes.select(:close).where("period = \"#{default_period}\"").order(time: :desc).limit(1).first[:close]
  end

  def self.over_five_day_moving_average
    over = []
    all.each do |s|
      over << s if s.price_over_five_day_moving_average?
    end
    over
  end
end
