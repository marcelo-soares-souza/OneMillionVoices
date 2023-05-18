# frozen_string_literal: true

class EvaluatesController < ApplicationController
  before_action :set_evaluate, only: %i[ show edit update destroy ]
  before_action :load_effective_options
  before_action :load_yes_no_i_am_not_sure_options
  before_action :load_options

  # GET /evaluates or /evaluates.json
  def index
    @evaluates = Evaluate.all
  end

  # GET /evaluates/1 or /evaluates/1.json
  def show
  end

  # GET /evaluates/new
  def new
    begin
      @practice_id = Practice.friendly.find(params[:practice_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to locais_path, notice: "This Practice doesn't exist."
    end

    @evaluate = Evaluate.new
  end

  # GET /evaluates/1/edit
  def edit
  end

  # POST /evaluates or /evaluates.json
  def create
    @evaluate = Evaluate.where(practice_id: params[:evaluate][:practice_id]).first

    respond_to do |format|
      if @evaluate
        @evaluate.update(evaluate_params)
        format.html { redirect_to new_practice_acknowledge_path(@evaluate.practice), notice: "Evaluate was successfully Updated." }
      else
        @evaluate = Evaluate.new(evaluate_params)
        if @evaluate.save
          format.html { redirect_to new_practice_acknowledge_path(@evaluate.practice), notice: "Evaluate was successfully created." }
          format.json { render :show, status: :created, location: @evaluate }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @evaluate.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /evaluates/1 or /evaluates/1.json
  def update
    respond_to do |format|
      if @evaluate.update(evaluate_params)
        format.html { redirect_to evaluate_url(@evaluate), notice: "Evaluate was successfully updated." }
        format.json { render :show, status: :ok, location: @evaluate }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @evaluate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluates/1 or /evaluates/1.json
  def destroy
    @evaluate.destroy

    respond_to do |format|
      format.html { redirect_to evaluates_url, notice: "Evaluate was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_evaluate
    @evaluate = Evaluate.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def evaluate_params
    params.require(:evaluate).permit(:practice_id, :general_performance_of_practice, :unintended_positive_side_effects_of_practice, :unintended_negative_side_effect_of_practice, :knowledge_and_skills_required_for_practice, :labour_required_for_practice, :cost_associated_with_practice, :system_integrity_requirements, :system_integrity_effects, :climate_change_vulnerability_effects, :time_requirements)
  end

  def load_options
    @knowledge_and_skills_required_for_practice_options = {
      t(:high_specialised_knowledge_required) => "High specialised knowledge required",
      t(:rather_high_specialised_knowledge_required) => "Rather high specialised knowledge required",
      t(:specialised_knowledge_required_neither_high_nor_low) => "Specialised knowledge required neither high nor low",
      t(:rather_low_specialised_knowledge_required) => "Rather low specialised knowledge required",
      t(:no_specialised_knowledge_required) => "No specialised knowledge required",
      t(:i_am_not_sure) => "I am not sure"
    }

    @cost_associated_with_practice_options = {
      t(:high_costs) => "High costs",
      t(:rather_high_costs) => "Rather high costs",
      t(:neither_high_nor_low_costs) => "Rather high costs",
      t(:rather_low_costs) => "Rather low costs",
      t(:low_costs) => "Low costs",
      t(:i_am_not_sure) => "I am not sure"
    }

    @labour_required_for_practice_options = {
      t(:high_labour_required) => "High labour required",
      t(:rather_high_labour_required) => "Rather high labour required",
      t(:neither_high_nor_low_labout_required) => "Neither high nor low labout required",
      t(:rather_low_labour_required) => "Rather low labour required",
      t(:low_labour_required) => "Low labour required",
      t(:i_am_not_sure) => "I am not sure"
    }

    @time_requirements_options = {
      t(:works_instantly) => "Works instantly",
      t(:works_rather_rapidly) => "Works rather rapidly",
      t(:works_neither_rapidly_nor_slowly) => "Works neither rapidly nor slowly",
      t(:takes_rather_long_to_work) => "Takes rather long to work",
      t(:takes_very_long_to_work) => "Takes very long to work",
      t(:i_am_not_sure) => "I am not sure"
    }

    @system_integrity_requirements_options = {
      t(:works_well_in_depleted_environment) => "Works well in depleted environment",
      t(:works_rather_well_in_depleted_environment) => "Works rather well in depleted environment",
      t(:neither_works_well_nor_poorly_in_depleted_environment) => "Neither works well nor poorly in depleted environment",
      t(:does_rather_not_work_in_depleted_environment) => "Does rather not work in depleted environment",
      t(:does_not_work_at_all_in_depleted_environment) => "Does not work at all in depleted environment",
      t(:i_am_not_sure) => "I am not sure"
    }
  end
end
