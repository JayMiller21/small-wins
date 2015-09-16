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

  private
    def habit_params
      params.require(:habit).permit(:name)
    end

end
