class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy, :awyea, :ohnoes]

  # GET /goals
  # GET /goals.json
  def index
    @goals = Goal.all
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = Goal.new(goal_params)

    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal, notice: 'Goal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @goal }
      else
        format.html { render action: 'new' }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to goals_url }
      format.json { head :no_content }
    end
  end

  def awyea
    unless @goal.last_success_at.try(:today?)
      @goal.increment(:current_streak)
      @goal.record_streak = [@goal.current_streak, @goal.record_streak].max
      @goal.last_success_at = Time.now
      @goal.save
    end

    redirect_to @goal
  end

  def ohnoes
    @goal.update_attributes(current_streak: 0, last_success_at: nil)
    redirect_to @goal
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      token = params[:id].split("-").first
      @goal = Goal.find_by_token(token)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params.require(:goal).permit(:name)
    end
end
