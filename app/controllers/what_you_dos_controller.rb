class WhatYouDosController < ApplicationController
  before_action :set_what_you_do, only: %i[ show edit update destroy ]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]

  # GET /what_you_dos or /what_you_dos.json
  def index
    @what_you_dos = WhatYouDo.all
  end

  # GET /what_you_dos/1 or /what_you_dos/1.json
  def show
  end

  # GET /what_you_dos/new
  def new
    @what_you_do = WhatYouDo.new
  end

  # GET /what_you_dos/1/edit
  def edit
  end

  # POST /what_you_dos or /what_you_dos.json
  def create
    @what_you_do = WhatYouDo.where(practice_id: params[:what_you_do][:practice_id]).first

    respond_to do |format|
      if @what_you_do
        @what_you_do.update(what_you_do_params)
        format.html { redirect_to new_practice_characterise_path(@what_you_do.practice), notice: "What you do was successfully Updated." }
      else
        @what_you_do = WhatYouDo.new(what_you_do_params)
        if @what_you_do.save
          format.html { redirect_to new_practice_characterise_path(@what_you_do.practice), notice: "What you do was successfully created." }
          format.json { render :show, status: :created, location: @what_you_do }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @what_you_do.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /what_you_dos/1 or /what_you_dos/1.json
  def update
    respond_to do |format|
      if @what_you_do.update(what_you_do_params)
        format.html { redirect_to what_you_do_url(@what_you_do), notice: "What you do was successfully updated." }
        format.json { render :show, status: :ok, location: @what_you_do }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @what_you_do.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /what_you_dos/1 or /what_you_dos/1.json
  def destroy
    @what_you_do.destroy

    respond_to do |format|
      format.html { redirect_to what_you_dos_url, notice: "What you do was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_what_you_do
    @what_you_do = WhatYouDo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def what_you_do_params
    params.require(:what_you_do).permit(:practice_id, :summary_description_of_agroecological_practice, :type_of_agroecological_practice, :problem_that_practice_addresses, :practical_implementation_of_the_practice, :expected_function_or_effects_of_practice)
  end
end
