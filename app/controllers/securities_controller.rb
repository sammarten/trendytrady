class SecuritiesController < ApplicationController
  def index
    @securities = Security.all
  end

  def show
    @security = Security.find(params[:id])
  end
end
