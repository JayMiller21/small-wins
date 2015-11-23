class Habit < ActiveRecord::Base
  has_many :completed_days
  has_many :chains
  belongs_to :user

  validates :name, presence: { message: " may not be blank" }

  validates :name, uniqueness: { message: "has already been used" }

  attr_accessor :start_date, :end_date

  # For a given habit, returns all completed days, sorted in ascending date order.
  def completed_days_sorted
    self.completed_days.where.not(date: nil).sort_by(&:date)
  end

  # For a given habit, returns an array of chains where each "chain" is a hash with the keys "start_date" and "end_date."
  def chains
    chains_enumerator = self.completed_days_sorted.slice_before { |completed_day|
      index = self.completed_days_sorted.index(completed_day)
      self.completed_days_sorted[index-1].date != completed_day.date-1.day
    }

    chains_enumerator.map { |chain| 
      chain = {:start_date => chain[0].date, :end_date => chain[-1].date}
    }
  end

  # For a given habit, returns the latest chain, meaning the one with the most recent start date.
  def latest_chain
    latest_chain = self.chains.max_by {|chain| chain[:start_date]} 
  end

  # For a given habit, returns the number of days in the latest chain.
  def latest_chain_length
    if latest_chain.nil?
      0
    else
      (self.latest_chain[:end_date] - self.latest_chain[:start_date]).to_i + 1
    end
  end

  # For a given habit, returns the longest chain, meaning the one with the most days.
  def longest_chain
    latest_chain = self.chains.max_by {|chain| chain[:end_date] - chain[:start_date]} 
  end

  # For a given habit, returns the number of days in the longest chain.
  def longest_chain_length
    if longest_chain.nil?
      0
    else
      (self.longest_chain[:end_date] - self.longest_chain[:start_date]).to_i + 1
    end
  end

  #
  def days_this_year
    self.completed_days.to_a.keep_if { |day|
      day.date.year == Time.now.year
    }.length
  end

  # For a given habit, returns habit data in the format needed for sending to javascript column chart.
  def formatted_for_column_chart
      [self.name,self.completed_days.map { |cd| cd.date_as_ymd_array}]
  end

  # For a habit collection, returns a json array of habit objects in the format needed for creating column charts in js.
  def self.formatted_for_column_chart
    jshabits_ruby = all.map { |habit|
        if !habit.chains[0].nil?
          habit.formatted_for_column_chart
        end
      }
    jshabits = jshabits_ruby.to_json
  end

  # def previous_longest_chain
  #   self.chains.where(current: FALSE).max_by{ |chain| chain.chain_length } 
  # end

  # def previous_longest_chain_length
  #   if previous_longest_chain.nil?
  #     0
  #   else
  #     self.previous_longest_chain.chain_length
  #   end
  # end

end
