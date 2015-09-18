class HabitsController < ApplicationController
  def index
    @habits = Habit.all
  end 

  def show
  end

  def new
    @habit = Habit.new
    @habits = Habit.all.sort_by(&:name)
  end

  def edit
    @habit = Habit.find(params[:id])
    @completed_days = @habit.completed_days.sort_by(&:date)
    @completed_day = CompletedDay.new
  end

  def create
    @habit = Habit.new(habit_params)
    @habits = Habit.all.sort_by(&:name)
    if @habit.save
      redirect_to habits_path
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  def create_completed_day
    @habit = Habit.find(params[:id])
    @completed_day = @habit.completed_days.new(completed_day_params)
    if @completed_day.save
      @habit.update_chains
      redirect_to habits_path
    else
      render 'edit'
    end
  end

  private
    def habit_params
      params.require(:habit).permit(:name)
    end

    def completed_day_params
      params.require(:completed_day).permit(:date)
    end

end
