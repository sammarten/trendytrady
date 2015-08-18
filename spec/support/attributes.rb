def security_attributes(overrides = {})
  {
    symbol: "AAPL",
    name: "Apple Corporation",
    exchange: "NASDAQ"
  }.merge(overrides)
end

def quote_attributes(overrides = {})
  {
    security_id: 1,
    time: "2015-06-19 09:35:00",
    open: 127.48,
    high: 127.57,
    low: 127.35,
    close: 127.38,
    volume: 760013,
    period: "5",
    date: "2015-06-19"
  }.merge(overrides)
end