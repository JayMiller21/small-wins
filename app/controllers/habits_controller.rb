class HabitsController < ApplicationController
  def index
    current_user_habits
  end 

  def show
  end

  def new
    current_user_habits
    @habit = current_user.habits.new
  end

  def edit
    @habit = Habit.find(params[:id])
    @completed_days = @habit.completed_days.sort_by(&:date)
    @completed_day = CompletedDay.new
  end

  def create
    current_user_habits
    @habit = current_user.habits.new(habit_params)
    if @habit.save
      redirect_to user_habits_path
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
    @habit = Habit.find(params[:id])
    @habit.destroy
    
    redirect_to user_habits_path
  end

  def create_completed_day
    @habit = Habit.find(params[:id])
    @completed_day = @habit.completed_days.new(completed_day_params)
    if @completed_day.save
      @habit.update_chains
      redirect_to user_habits_path
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

    def current_user_habits
      @habits = current_user.habits.sort_by(&:name)
    end

end
