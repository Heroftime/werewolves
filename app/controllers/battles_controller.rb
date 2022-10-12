class BattlesController < ApplicationController
  before_action :set_battle, only: %i[ show edit update destroy ]

  # GET /battles or /battles.json
  def index
    @battles = Battle.all
  end

  # GET /battles/1 or /battles/1.json
  def show
    @battle_logs = BattleLog.where(battle_id: params[:id])
  end

  # GET /battles/new
  def new
    @battle = Battle.new
  end

  # GET /battles/1/edit
  def edit
  end

  # POST /battles or /battles.json
  def create
    @battle = Battle.new(battle_params)

    respond_to do |format|
      if @battle.save
        # Battle should be executed as soon it is submitted
        BattleProcessorJob.perform_now
        format.html { redirect_to battle_url(@battle), notice: "Battle was successfully created." }
        format.json { render :show, status: :created, location: @battle }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /battles/1 or /battles/1.json
  def update
    respond_to do |format|
      if @battle.update(battle_params)
        format.html { redirect_to battle_url(@battle), notice: "Battle was successfully updated." }
        format.json { render :show, status: :ok, location: @battle }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @battle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /battles/1 or /battles/1.json
  def destroy
    @battle.destroy

    respond_to do |format|
      format.html { redirect_to battles_url, notice: "Battle was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_battle
    @battle = Battle.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def battle_params
    params.require(:battle).permit(:initiator_id, :opponent_id, :status, :winner_id)
  end
end
