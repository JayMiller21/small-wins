class CompletedDaysController < ApplicationController
  
  def index
    @completed_days = CompletedDay.all.sort_by(&:date)
  end

  def new
    @completed_days = CompletedDay.all.sort_by(&:date)
    @completed_day = CompletedDay.new
  end

  def create
    @completed_days = CompletedDay.all.sort_by(&:date)
    @completed_day = CompletedDay.new(completed_day_params)
    if @completed_day.save
      CompletedDay.update_chains
      redirect_to habits_path
    else
      render 'new'
    end
  end

  def destroy
    @completed_day = CompletedDay.find(params[:id])
    @completed_day.destroy
    CompletedDay.update_chains
    redirect_to chains_path
  end

  private
    def completed_day_params
      params.require(:completed_day).permit(:date)
    end

end
