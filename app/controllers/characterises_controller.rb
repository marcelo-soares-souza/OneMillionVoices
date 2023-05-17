class CharacterisesController < ApplicationController
  before_action :set_characterise, only: %i[ show edit update destroy ]

  # GET /characterises or /characterises.json
  def index
    @characterises = Characterise.all
  end

  # GET /characterises/1 or /characterises/1.json
  def show
  end

  # GET /characterises/new
  def new
    @characterise = Characterise.new
  end

  # GET /characterises/1/edit
  def edit
  end

  # POST /characterises or /characterises.json
  def create
    @characterise = Characterise.new(characterise_params)

    respond_to do |format|
      if @characterise.save
        format.html { redirect_to new_practice_evaluate_path(@characterise.practice), notice: "Characterise was successfully created." }
        format.json { render :show, status: :created, location: @characterise }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @characterise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /characterises/1 or /characterises/1.json
  def update
    respond_to do |format|
      if @characterise.update(characterise_params)
        format.html { redirect_to characterise_url(@characterise), notice: "Characterise was successfully updated." }
        format.json { render :show, status: :ok, location: @characterise }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @characterise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /characterises/1 or /characterises/1.json
  def destroy
    @characterise.destroy

    respond_to do |format|
      format.html { redirect_to characterises_url, notice: "Characterise was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_characterise
      @characterise = Characterise.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def characterise_params
      params.require(:characterise).permit(:practice_id, :agroecology_principles_addressed, :food_system_components_addressed)
    end
end
