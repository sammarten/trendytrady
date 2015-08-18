require 'rails_helper'

describe "Navigating securities" do
  it "allows navigation from the detail page to the listing page" do
    security = Security.create(security_attributes)
    quote = Quote.create(quote_attributes)

    # hate that below does not work
    # wonder if it's because capybara takes over the object and executes?
    # allow(security).to receive(:last_price).and_return(65.25)

    visit security_url(security)

    click_link "All Securities"

    expect(current_path).to eq(securities_path)
  end

  it "can stub an object's method" do
    security = Security.create(security_attributes)
    allow(security).to receive(:last_price).and_return(65.25)
    
    # following works but :stub method is deprecated; use allow
    # security.stub(:last_price) { 65.25 }     

    expect(security.last_price).to eq(65.25)
  end

  it "allows navigation from the listing page to the detail page" do
    security = Security.create(security_attributes)
    quote = Quote.create(quote_attributes)

    visit securities_url

    click_link security.symbol

    expect(current_path).to eq(security_path(security))
  end
end