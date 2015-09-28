class CompletedDay < ActiveRecord::Base
  belongs_to :chain
  belongs_to :habit
  
  validates :date, format: { with: /\d{4}-\d{2}-\d{2}/, :message => "must be in the following format: yyyy-mm-dd" }

  validates :date, presence: { message: " may not be blank" }

  validates :date, uniqueness: { scope: [:habit_id], message: "has already been logged" }

  validates :date, :timeliness => {:on_or_before => lambda { Date.current }, :type => :date, :on_or_before_message => "is in the future"}

  def date_as_ymd_array
    [self.date.year,
        self.date.month,
        self.date.day]
  end

end
