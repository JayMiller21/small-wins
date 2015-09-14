class CompletedDay < ActiveRecord::Base
  belongs_to :chain

  def self.update_chains
    completed_days = CompletedDay.all.sort_by(&:date)

        chains = completed_days.slice_before { |completed_day|
          index = completed_days.index(completed_day)
          completed_days[index-1].date != completed_day.date-1.day
        }

        Chain.destroy_all
        @chains = chains.map { |chain| 
          Chain.create(:start_date => chain[0].date, :end_date => chain[-1].date, :current => FALSE)
        }
        # TODO:
        # assign current chain
        # apply this method on deleting a completed day as well
        # try sidekiq for async 
  end
end
