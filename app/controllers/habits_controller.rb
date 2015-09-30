class HabitsController < ApplicationController
  def index
    current_user_habits 
    @jshabits = current_user_habits.formatted_for_column_chart
    no_chains_message
    no_habits_message
  end 

  def new
    current_user_habits 
    @habit = current_user.habits.new
  end

  def edit
    habit
    completed_days
    @completed_day = CompletedDay.new
  end

  def create
    current_user_habits 
    habit_params[:name].titleize!
    @habit = current_user.habits.new(habit_params)
    if @habit.save
      redirect_to user_habits_path(current_user)
    else
      render 'new'
    end
  end

  def destroy
    habit
    habit.destroy
    redirect_to user_habits_path(current_user)
  end

  def create_completed_day
    habit
    completed_days
    @completed_day = @habit.completed_days.new(completed_day_params)
    if @completed_day.save
      redirect_to user_habits_path(current_user)
    else
      render 'edit'
    end
  end

  private
    # params from new habit form
    def habit_params
      params.require(:habit).permit(:name)
    end

    # params from new completed day form
    def completed_day_params
      params.require(:completed_day).permit(:date)
    end

    # Message to display in habit panel when no completed days have been logged for the given habit.
    def no_chains_message
      @no_chains_message = "You have not logged any days yet!"
    end

    # Message to display in habits panel when no habits have been created.
    def no_habits_message
      @no_habits_message = "You're not tracking any habits yet!"
    end

    # Array of current user's habits
    def current_user_habits
      @habits = current_user.habits
    end

    # Habit object from params
    def habit
      @habit = Habit.find(params[:id])
    end

    # Habit's completed days sorted
    def completed_days
      @completed_days = habit.completed_days_sorted
    end

end
