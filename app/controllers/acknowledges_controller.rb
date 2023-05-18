# frozen_string_literal: true

class AcknowledgesController < ApplicationController
  before_action :set_acknowledge, only: %i[ show edit update destroy ]
  before_action :load_knowledge_sources

  # GET /acknowledges or /acknowledges.json
  def index
    @acknowledges = Acknowledge.all
  end

  # GET /acknowledges/1 or /acknowledges/1.json
  def show
  end

  # GET /acknowledges/new
  def new
    begin
      @practice_id = Practice.friendly.find(params[:practice_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to locais_path, notice: "This Practice doesn't exist."
    end

    @acknowledge = Acknowledge.new
  end

  # GET /acknowledges/1/edit
  def edit
  end

  # POST /acknowledges or /acknowledges.json
  def create
    @acknowledge = Acknowledge.where(practice_id: params[:acknowledge][:practice_id]).first

    respond_to do |format|
      if @acknowledge
        @acknowledge.update(acknowledge_params)
        format.html { redirect_to local_practice_path(@acknowledge.practice.local, @acknowledge.practice), notice: "Acknowledges was successfully Updated." }
      else
        @acknowledge = Acknowledge.new(acknowledge_params)
        if @acknowledge.save
          format.html { redirect_to local_practice_path(@acknowledge.practice.local, @acknowledge.practice), notice: "Acknowledges was successfully created." }
          format.json { render :show, status: :created, location: @acknowledge }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @acknowledge.errors, status: :unprocessable_entity }
        end
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

  def load_knowledge_sources
    @knowledge_source_options = {
      t(:formal_knowledge) => "Formal knowledge",
      t(:indigenous_knowledge) => "Indigenous knowledge",
      t(:local_knowledge) => "Local knowledge",
      t(:personal_experimentation) => "Personal experimentation",
      t(:other) => "Other",
      t(:i_am_not_sure) => "I am not sure"
    }
  end
end
