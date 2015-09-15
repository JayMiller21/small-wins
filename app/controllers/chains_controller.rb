class ChainsController < ApplicationController
  def index
    @chains = Chain.all

    previous_longest_chain = Chain.where(current: FALSE).max_by{ |chain| chain.chain_length } 
    @previous_longest_chain_length = previous_longest_chain.chain_length
  end
end
