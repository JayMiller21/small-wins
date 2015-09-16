class Habit < ActiveRecord::Base
  has_many :completed_days
  has_many :chains

  def previous_longest_chain
    self.chains.where(current: FALSE).max_by{ |chain| chain.chain_length } 
  end

  def previous_longest_chain_length
    self.previous_longest_chain.chain_length
  end

  def current_chain
    self.chains.where(current: TRUE)[0]
  end

  def current_chain_dates
    (self.current_chain.start_date..self.current_chain.end_date).map{ |date| date.strftime("%b %d") }
  end

  def upcoming_dates
    (self.current_chain.end_date+1..self.current_chain.end_date+5).map{ |date| date.strftime("%b %d") }
  end

end
