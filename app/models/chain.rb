class Chain < ActiveRecord::Base
  has_many :completed_days
  belongs_to :habit

  # Calculates the number of completed days in a chain
  def chain_length
    (self[:end_date] - self[:start_date]).to_i + 1
  end

end
