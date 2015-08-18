require 'rails_helper'

describe "A security" do
  it "calculates its five day moving average" do
    security = Security.create(security_attributes)

    Period.create({
        symbol: "d",
        name: "daily",
        time_in_mins: 390
      })

    time_now = Time.now

    6.times do |t|
      Quote.create(quote_attributes({
          time: time_now - t,
          close: 127.0 - t,
          period: "d"
        }))
    end

    expect(security.five_day_moving_average(period: "d")).to be_within(0.01).of(125.00)
  end  

  it "calculates its five day moving average for different quote periods" do
    security = Security.create(security_attributes)

    Period.create({
        symbol: "30",
        name: "30 minutes",
        time_in_mins: 30
      })

    time_now = Time.now

    70.times do |t|
      Quote.create(quote_attributes({
          time: time_now - t,
          close: 127.0 - t,
          period: "30"
        }))
    end

    expect(security.five_day_moving_average(period: "30")).to be_within(0.01).of(95.00)
  end

  it "returns true if current price is above 5 day moving average" do
    security = Security.create(security_attributes())

    Period.create({
        symbol: "5",
        name: "5 minutes",
        time_in_mins: 5
      })

    time_now = Time.now

    Quote.create(quote_attributes({
      time: time_now,
      close: 107.51,
      period: "5"
    }))

    (1..399).each do |t|
      Quote.create(quote_attributes({
        time: time_now - t,
        close: 127.0 - (0.1 * t),
        period: "5"
      }))
    end
    
    expect(security.price_over_five_day_moving_average?).to be(true)
  end

  it "returns false if current price is under the 5 day moving average" do 
    security = Security.create(security_attributes())

    Period.create({
        symbol: "5",
        name: "5 minutes",
        time_in_mins: 5
      })

    time_now = Time.now

    Quote.create(quote_attributes({
      time: time_now,
      close: 107.49,
      period: "5"
    }))

    (1..399).each do |t|
      Quote.create(quote_attributes({
        time: time_now - t,
        close: 127.0 - (0.1 * t),
        period: "5"
      }))
    end
    
    expect(security.price_over_five_day_moving_average?).to be(false)
  end

  it "has a last price" do 
    security = Security.create(security_attributes())

    time_now = Time.now

    Quote.create(quote_attributes({
      time: time_now,
      close: 107.49,
      period: "5"
    }))

    expect(security).to respond_to(:last_price)
  end

  it "has multiple quotes" do
    security = Security.create(security_attributes())

    time_now = Time.now

    quote1 = security.quotes.create({
      time: "2015-06-19 09:35:00",
      open: 127.48,
      high: 127.57,
      low: 127.35,
      close: 127.38,
      volume: 760013,
      period: "5",
      date: "2015-06-19"
    })

    quote2 = security.quotes.create({
      time: "2015-06-19 09:40:00",
      open: 127.48,
      high: 127.57,
      low: 127.35,
      close: 127.38,
      volume: 760013,
      period: "5",
      date: "2015-06-19"
    })

    expect(security.quotes.count).to eq(2)

  end

  it "returns a list of securities over their five day moving average" do
    security1 = Security.create(security_attributes())
    security2 = Security.create(security_attributes({
      symbol: "CERN", 
      name: "Cerner Corporation"
    }))

    Period.create({
        symbol: "5",
        name: "5 minutes",
        time_in_mins: 5
      })

    time_now = Time.now

    Quote.create(quote_attributes({
      time: time_now,
      close: 107.51,
      period: "5"
    }))

    (1..399).each do |t|
      Quote.create(quote_attributes({
        time: time_now - t,
        close: 127.0 - (0.1 * t),
        period: "5"
      }))
    end

    Quote.create(quote_attributes({
      security_id: 2,
      time: time_now,
      close: 107.49,
      period: "5"
    }))

    (1..399).each do |t|
      Quote.create(quote_attributes({
        security_id: 2,
        time: time_now - t,
        close: 127.0 - (0.1 * t),
        period: "5"
      }))
    end

    expect(Security.over_five_day_moving_average).to include(security1)
  end

  it "excludes securities not over their five day moving average" do 
    security1 = Security.create(security_attributes())
    security2 = Security.create(security_attributes({
      symbol: "CERN", 
      name: "Cerner Corporation"
    }))

    Period.create({
        symbol: "5",
        name: "5 minutes",
        time_in_mins: 5
      })

    time_now = Time.now

    Quote.create(quote_attributes({
      time: time_now,
      close: 107.51,
      period: "5"
    }))

    (1..399).each do |t|
      Quote.create(quote_attributes({
        time: time_now - t,
        close: 127.0 - (0.1 * t),
        period: "5"
      }))
    end

    Quote.create(quote_attributes({
      security_id: 2,
      time: time_now,
      close: 107.49,
      period: "5"
    }))

    (1..399).each do |t|
      Quote.create(quote_attributes({
        security_id: 2,
        time: time_now - t,
        close: 127.0 - (0.1 * t),
        period: "5"
      }))
    end

    expect(Security.over_five_day_moving_average).not_to include(security2)
  end
end