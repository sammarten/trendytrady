require 'rails_helper'

describe "Viewing list of all securities" do

  it "shows the securities" do

    security1 = Security.create(symbol: "AAPL",
                                name: "Apple Corporation",
                                exchange: "NASDAQ")

    security2 = Security.create(symbol: "AMZN",
                                name: "Amazon",
                                exchange: "NASDAQ")

    security3 = Security.create(symbol: "CERN",
                                name: "Cerner Corporation",
                                exchange: "NASDAQ")

    security4 = Security.create(symbol: "DIS",
                                name: "Disney",
                                exchange: "NYSE")

    security5 = Security.create(symbol: "GOOG",
                                name: "Google",
                                exchange: "NASDAQ")

    visit securities_url

    expect(page).to have_text("5 Securities")
    expect(page).to have_text(security1.symbol)
    expect(page).to have_text(security2.symbol)
    expect(page).to have_text(security3.symbol)
    expect(page).to have_text(security4.symbol)
    expect(page).to have_text(security5.symbol)
  end
  
end
