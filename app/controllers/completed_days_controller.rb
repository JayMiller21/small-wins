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
      
      CompletedDay.update_chains
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
