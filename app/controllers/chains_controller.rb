class ChainsController < ApplicationController
  def index
    @chains = Chain.all

    previous_longest_chain = Chain.where(current: FALSE).max_by{ |chain| chain.chain_length } 
    @previous_longest_chain_length = previous_longest_chain.chain_length

    @current_chain = Chain.where(current: TRUE)[0]
    @current_chain_dates = (@current_chain.start_date..@current_chain.end_date).map{ |date| date.strftime("%b %d") }
  end
end
