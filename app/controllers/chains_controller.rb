class ChainsController < ApplicationController
  def index
    @chains = Chain.all
  end
end
