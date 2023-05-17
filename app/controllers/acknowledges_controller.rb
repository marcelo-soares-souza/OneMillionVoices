class AcknowledgesController < ApplicationController
  before_action :set_acknowledge, only: %i[ show edit update destroy ]

  # GET /acknowledges or /acknowledges.json
  def index
    @acknowledges = Acknowledge.all
  end

  # GET /acknowledges/1 or /acknowledges/1.json
  def show
  end

  # GET /acknowledges/new
  def new
    @acknowledge = Acknowledge.new
  end

  # GET /acknowledges/1/edit
  def edit
  end

  # POST /acknowledges or /acknowledges.json
  def create
    @acknowledge = Acknowledge.new(acknowledge_params)

    respond_to do |format|
      if @acknowledge.save
        format.html { redirect_to local_path(@acknowledge.practice.local), notice: "Acknowledge was successfully created." }
        format.json { render :show, status: :created, location: @acknowledge }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @acknowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /acknowledges/1 or /acknowledges/1.json
  def update
    respond_to do |format|
      if @acknowledge.update(acknowledge_params)
        format.html { redirect_to acknowledge_url(@acknowledge), notice: "Acknowledge was successfully updated." }
        format.json { render :show, status: :ok, location: @acknowledge }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @acknowledge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /acknowledges/1 or /acknowledges/1.json
  def destroy
    @acknowledge.destroy

    respond_to do |format|
      format.html { redirect_to acknowledges_url, notice: "Acknowledge was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_acknowledge
      @acknowledge = Acknowledge.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def acknowledge_params
      params.require(:acknowledge).permit(:practice_id, :knowledge_source, :knowledge_timing, :knowledge_products)
    end
end
