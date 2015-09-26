class HabitsController < ApplicationController
  def index
    @habits = current_user.habits

    if !@habits[0].nil?
      @jshabits_ruby = @habits.map { |habit|
        if !habit.chains[0].nil?
          habit.formatted_for_area_chart
        end
      }
      if !@jshabits_ruby[0].nil?
        @jshabits = @jshabits_ruby.to_json
      end
    end
    @no_chains_message = "You have not logged any days yet!"
    @no_habits_message = "You're not tracking any habits yet!"
  end 

  def show
  end

  def new
    @habits = current_user.habits
    @habit = current_user.habits.new
  end

  def edit
    @habit = Habit.find(params[:id])
    @completed_days = @habit.completed_days.sort_by(&:date)
    @completed_day = CompletedDay.new
  end

  def create
    @habits = current_user.habits
    habit_params[:name].capitalize!
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
    
    redirect_to user_habits_path(current_user)
  end

  def create_completed_day
    @habit = Habit.find(params[:id])
    @completed_day = @habit.completed_days.new(completed_day_params)
    if @completed_day.save
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

    # def current_user_habits
    #   @habits = current_user.habits.sort_by(&:name)
    # end

end
