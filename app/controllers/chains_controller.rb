class ChainsController < ApplicationController
  def index
    @chains = Chain.all

    previous_longest_chain = Chain.where(current: FALSE).max_by{ |chain| chain.chain_length } 
    @previous_longest_chain_length = previous_longest_chain.chain_length

    @latest_chain = Chain.where(current: TRUE)[0]
    @latest_chain_dates = (@latest_chain.start_date..@latest_chain.end_date).map{ |date| date.strftime("%b %d") }
    @upcoming_dates = (@latest_chain.end_date+1..@latest_chain.end_date+5).map{ |date| date.strftime("%b %d") }
  end
end
