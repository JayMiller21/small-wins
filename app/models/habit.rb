class Habit < ActiveRecord::Base
  has_many :completed_days
  has_many :chains
  belongs_to :user

  def completed_days_sorted
    self.completed_days.sort_by(&:date)
  end

  def latest_chain
    self.chains.max_by {|chain| chain.start_date}
  end

  def current_chain
    if latest_chain.nil?
      return nil
    else
      if Date.today >= self.latest_chain.start_date && Date.today <=latest_chain.end_date
        return latest_chain
      else
        return nil
      end
    end
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

  def update_chains

    self.chains.destroy_all

    chains_enumerator = self.completed_days_sorted.slice_before { |completed_day|
      index = self.completed_days_sorted.index(completed_day)
      self.completed_days_sorted[index-1].date != completed_day.date-1.day
    }

    chains_enumerator.map { |chain| 
      Chain.create(:start_date => chain[0].date, :end_date => chain[-1].date, :current => FALSE, :habit_id => self.id)
    }

    if !self.current_chain.nil?
      self.current_chain.update_attribute(:current, TRUE)
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

end
