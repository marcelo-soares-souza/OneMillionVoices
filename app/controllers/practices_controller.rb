# frozen_string_literal: true

class PracticesController < ApplicationController
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action lambda { check_owner Practice.friendly.find(params[:id]).usuario_id }, only: %i[edit update destroy]

  before_action :set_practice, only: %i[show edit update destroy]
  before_action :load_locais, except: %i[index show]
  before_action :load_local
  before_action :load_usuario

  # GET /practices
  # GET /practices.json
  def index
    @practices = if params[:local_id]
      Practice.where(local_id: @local.id).load_async.sort_by(&:updated_at).reverse
    elsif params[:usuario_id]
      Practice.where(usuario_id: @usuario.id).load_async.sort_by(&:updated_at).reverse
    else
      Practice.order("updated_at DESC").load_async.page(params[:page])
    end
  end

  # GET /practices/1
  # GET /practices/1.json
  def show
  end

  # GET /practices/new
  def new
    @practice = Practice.new
  end

  # GET /practices/1/edit
  def edit; end

  # POST /practices
  # POST /practices.json
  def create
    @practice = Practice.new(practice_params)
    @practice.usuario_id = current_usuario.id unless current_usuario.admin?

    respond_to do |format|
      if @practice.save
        @what_you_do = WhatYouDo.new(practice_id: @practice.id).save!
        @characterise = Characterise.new(practice_id: @practice.id).save!
        @evaluate = Evaluate.new(practice_id: @practice.id).save!
        @acknowledge = Acknowledge.new(practice_id: @practice.id).save!

        format.html { redirect_to new_practice_what_you_do_path(@practice), notice: "Practice Registered" }
        format.json { render :show, status: :created, location: @practice }
      else
        format.html { render :new }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /practices/1
  # PATCH/PUT /practices/1.json
  def update
    respond_to do |format|
      if @practice.update(practice_params)
        format.html { redirect_to @practice, notice: "A Practice has been Updated" }
        format.json { render :show, status: :ok, location: @practice }
      else
        format.html { render :edit }
        format.json { render json: @practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /practices/1
  # DELETE /practices/1.json
  def destroy
    @practice.destroy
    respond_to do |format|
      format.html { redirect_to practices_url, notice: "Agroecological Practice has been Removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_practice
      @practice = Practice.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def practice_params
      params.require(:practice).permit(:name, :slug, :local_id, :usuario_id)
    end

    def load_local
      @local = Local.friendly.find(params[:local_id]) if params[:local_id]
    end

    def load_usuario
      @usuario = Usuario.friendly.find(params[:usuario_id]) if params[:usuario_id]
    end
end
