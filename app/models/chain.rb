class Chain < ActiveRecord::Base
  has_many :completed_days
  belongs_to :habit

  def chain_length
    (self[:end_date] - self[:start_date]).to_i + 1
  end

end
