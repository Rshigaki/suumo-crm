class InteractionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_interaction, only: %i[ show edit update destroy ]

  # GET /interactions or /interactions.json
  def index
    @interactions = current_user.company.interactions.includes(:user, :customer).order(created_at: :desc)
  end

  # GET /interactions/1 or /interactions/1.json
  def show
  end

  # GET /interactions/new
  def new
    @interaction = Interaction.new
  end

  # GET /interactions/1/edit
  def edit
  end

  # POST /interactions or /interactions.json
  def create
    @interaction = current_user.company.interactions.build(user: current_user, started_at: Time.current, status: :recording)
    
    if @interaction.save
      redirect_to edit_interaction_path(@interaction)
    else
      redirect_to interactions_path, alert: "Could not start recording."
    end
  end

  # PATCH/PUT /interactions/1 or /interactions/1.json
  def update
    respond_to do |format|
      if @interaction.update(interaction_params)
        if @interaction.completed?
           # Award points
           PointLog.create(user: current_user, company: current_user.company, points: 10, reason: "Interaction Completed")
          format.html { redirect_to @interaction, notice: "Interaction completed. You earned 10 points!" }
        else
          format.html { redirect_to edit_interaction_path(@interaction), status: :see_other }
        end
        format.json { render :show, status: :ok, location: @interaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interactions/1 or /interactions/1.json
  def destroy
    @interaction.destroy!

    respond_to do |format|
      format.html { redirect_to interactions_path, notice: "Interaction was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interaction
      @interaction = current_user.company.interactions.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def interaction_params
      params.expect(interaction: [ :customer_id, :started_at, :ended_at, :recording_url, :transcript, :memo, :questionnaire_data, :status ])
    end
end
