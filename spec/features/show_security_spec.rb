require 'rails_helper'

describe "Showing a security" do

  it "shows details about the security" do

    security = Security.create(security_attributes)
    quote = Quote.create(quote_attributes)

    visit security_url(security)

    expect(page).to have_text(security.symbol)
    expect(page).to have_text(security.name)
    expect(page).to have_text(security.exchange)
    expect(page).to have_text(security.last_price.round(2))
  end
end