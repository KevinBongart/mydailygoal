class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy, :awyea]

  # GET /goals/1
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new
    set_hints
  end

  # GET /goals/1/edit
  def edit
    set_hints
  end

  # POST /goals
  def create
    @goal = Goal.new(goal_params)

    if @goal.save
      redirect_to @goal, notice: "Great! Expect an email tomorrow morning."
    else
      set_hints
      render action: "new"
    end
  end

  # PATCH/PUT /goals/1
  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: "Goal was successfully updated."
    else
      render action: "edit"
    end
  end

  def awyea
    @goal.success!
    redirect_to @goal, notice: "You're awesome!"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_goal
    token = params[:id].split("-").first
    @goal = Goal.find_by_token(token)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def goal_params
    params.require(:goal).permit(:name, :email)
  end

  def set_hints
    @hints = [
      "Quit smoking",
      "Exercise",
      "Cook",
      "Wake up early",
      "Hit the gym"
    ].shuffle
  end
end
