class Habit < ActiveRecord::Base
  has_many :completed_days
  has_many :chains

    def update_chains
    completed_days = self.completed_days.sort_by(&:date)

        chains = completed_days.slice_before { |completed_day|
          index = completed_days.index(completed_day)
          completed_days[index-1].date != completed_day.date-1.day
        }

        self.chains.destroy_all

        @chains = chains.map { |chain| 
          Chain.create(:start_date => chain[0].date, :end_date => chain[-1].date, :current => FALSE, :habit_id => self.id)
        }

        latest_chain = self.chains.max_by {|chain| chain.start_date}
        if Date.today >= latest_chain.start_date && Date.today <=latest_chain.end_date
          latest_chain.current = TRUE
          latest_chain.save
        end
        # TODO:
        # try sidekiq for async 
  end

  def previous_longest_chain
    self.chains.where(current: FALSE).max_by{ |chain| chain.chain_length } 
  end

  def previous_longest_chain_length
    if previous_longest_chain.nil?
      0
    else
      self.previous_longest_chain.chain_length
    end
  end

  def current_chain
    self.chains.where(current: TRUE)[0]
  end

  def current_chain_dates
    if self.current_chain.nil?
      return []
    else
      (self.current_chain.start_date..self.current_chain.end_date).map{ |date| date.strftime("%b %d") }
    end
  end

  def upcoming_dates
    if self.current_chain.nil?
      (Date.today..Date.today+4).map{ |date| date.strftime("%b %d") }
    else
      (self.current_chain.end_date+1..self.current_chain.end_date+5).map{ |date| date.strftime("%b %d") }
    end
  end

end
