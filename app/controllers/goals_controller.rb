class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy, :awyea]
  before_action :set_hints, only: [:new, :edit, :create, :update]

  http_basic_authenticate_with name: "admin", password: "ick5lAip0Cec7naW8jeeNs9ik3veG5", only: :index

  def index
    @goals = Goal.all
  end

  # GET /goals/1
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new

    if hint = params[:hint]
      @hint = hint.underscore.humanize
      @hints.delete(@hint)
      @hints.unshift(@hint)
    end

    @sample_goal = Goal.new(name: @hints.first, token: "d313a8ed", current_streak: rand(9..17))
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  def create
    @goal = Goal.new(goal_params)

    if @goal.save
      redirect_to @goal, notice: "Great! Expect an email tomorrow morning."
    else
      render action: "new"
    end
  end

  # PATCH/PUT /goals/1
  def update
    if @goal.update(goal_params)
      redirect_to @goal, notice: "All good!"
    else
      render action: "edit"
    end
  end

  # DELETE /goals/1
  def destroy
    @goal.destroy
    redirect_to root_path, notice: "No hard feelings!"
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
      "Read",
      "Eat a fruit"
    ].shuffle
  end
end
