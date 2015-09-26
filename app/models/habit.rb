class Habit < ActiveRecord::Base
  has_many :completed_days
  has_many :chains
  belongs_to :user

  validates :name, presence: { message: " may not be blank" }

  validates :name, uniqueness: { message: "has already been used" }

  attr_accessor :start_date, :end_date

  def completed_days_sorted
    self.completed_days.sort_by(&:date)
  end

  def latest_chain
    latest_chain = self.chains.max_by {|chain| chain["start_date"]} 
  end

  def latest_chain_length
    if latest_chain.nil?
      0
    else
      (self.latest_chain[:end_date] - self.latest_chain[:start_date]).to_i + 1
    end
  end

  def formatted_for_area_chart
      [self.name,
        [self.latest_chain[:start_date].year,
        self.latest_chain[:start_date].month,
        self.latest_chain[:start_date].day],
        [self.latest_chain[:end_date].year,
        self.latest_chain[:end_date].month,
        self.latest_chain[:end_date].day]
      ]
  end

  def chains

    chains_enumerator = self.completed_days_sorted.slice_before { |completed_day|
      index = self.completed_days_sorted.index(completed_day)
      self.completed_days_sorted[index-1].date != completed_day.date-1.day
    }

    chains_enumerator.map { |chain| 
      chain = {:start_date => chain[0].date, :end_date => chain[-1].date}
    }

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
