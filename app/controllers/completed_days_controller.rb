class CompletedDaysController < ApplicationController
  
  def index
    @completed_days = CompletedDay.all.sort_by(&:date)
  end

  def new
    @completed_day = CompletedDay.new
  end

  def create
    @completed_day = CompletedDay.new(completed_day_params)

    if @completed_day.save
      redirect_to action: "index"
      
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
    else
      render 'new'
    end
  end

  def destroy
    @completed_day = CompletedDay.find(params[:id])
    @completed_day.destroy
   
    redirect_to action: "index"
  end

  private
    def completed_day_params
      params.require(:completed_day).permit(:date)
    end

end
