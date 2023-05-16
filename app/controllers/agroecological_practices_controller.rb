# frozen_string_literal: true

class AgroecologicalPracticesController < ApplicationController
  before_action :set_agroecological_practice, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action lambda {
    check_owner AgroecologicalPractice.find(params[:id]).usuario_id
  }, only: %i[edit update destroy]
  before_action :load_locais, except: %i[index show]
  before_action :load_local
  before_action :load_usuario

  # GET /agroecological_practices
  # GET /agroecological_practices.json
  def index
    @agroecological_practices = if params[:local_id]
      AgroecologicalPractice.where(local_id: @local.id).load_async.sort_by(&:updated_at).reverse
    elsif params[:usuario_id]
      AgroecologicalPractice.where(usuario_id: @usuario.id).load_async.sort_by(&:updated_at).reverse
    else
      AgroecologicalPractice.order("updated_at DESC").page(params[:page])
    end
  end

  # GET /agroecological_practices/1
  # GET /agroecological_practices/1.json
  def show
  end

  # GET /agroecological_practices/new
  def new
    @agroecological_practice = AgroecologicalPractice.new
  end

  # GET /agroecological_practices/1/edit
  def edit; end

  # POST /agroecological_practices
  # POST /agroecological_practices.json
  def create
    @agroecological_practice = AgroecologicalPractice.new(agroecological_practice_params)
    @agroecological_practice.usuario_id = current_usuario.id unless current_usuario.admin?

    respond_to do |format|
      if @agroecological_practice.save
        format.html { redirect_to @agroecological_practice, notice: "A new Agroecological Practice has been Registered" }
        format.json { render :show, status: :created, location: @agroecological_practice }
      else
        format.html { render :new }
        format.json { render json: @agroecological_practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agroecological_practices/1
  # PATCH/PUT /agroecological_practices/1.json
  def update
    respond_to do |format|
      if @agroecological_practice.update(agroecological_practice_params)
        format.html { redirect_to @agroecological_practice, notice: "A Agroecological Practice has been Updated" }
        format.json { render :show, status: :ok, location: @agroecological_practice }
      else
        format.html { render :edit }
        format.json { render json: @agroecological_practice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agroecological_practices/1
  # DELETE /agroecological_practices/1.json
  def destroy
    @agroecological_practice.destroy
    respond_to do |format|
      format.html { redirect_to locais_url, notice: "Agroecological Practice has been Removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agroecological_practice
      @agroecological_practice = AgroecologicalPractice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agroecological_practice_params
      params.require(:agroecological_practice).permit(:summary_description, :problem_it_address, :how_it_is_done, :expected_function_effects, :general_evaluate, :local_id, :usuario_id, principles: [])
    end

    def load_local
      @local = Local.friendly.find(params[:local_id]) if params[:local_id]
    end

    def load_usuario
      @usuario = Usuario.friendly.find(params[:usuario_id]) if params[:usuario_id]
    end
end
