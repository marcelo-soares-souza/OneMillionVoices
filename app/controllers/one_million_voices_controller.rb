# frozen_string_literal: true

class OneMillionVoicesController < ApplicationController
  before_action :set_one_million_voice, only: %i[ show edit update destroy ]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]

  before_action lambda {
    check_owner OneMillionVoice.find(params[:id]).usuario_id
  }, only: %i[edit update destroy]

  before_action :load_locais, except: %i[index show]
  before_action :load_local
  before_action :load_usuario

  # GET /one_million_voices or /one_million_voices.json
  def index
    if params[:local_id]
      @one_million_voice = OneMillionVoice.where(local_id: @local.id).load_async.sort_by(&:updated_at).reverse.first
    else
      @one_million_voices = OneMillionVoice.all
    end
  end

  # GET /one_million_voices/1 or /one_million_voices/1.json
  def show
  end

  # GET /one_million_voices/new
  def new
    @one_million_voice = OneMillionVoice.new
  end

  # GET /one_million_voices/1/edit
  def edit
  end

  # POST /one_million_voices or /one_million_voices.json
  def create
    @one_million_voice = OneMillionVoice.new(one_million_voice_params)

    @one_million_voice.usuario_id = current_usuario.id unless current_usuario.admin?

    respond_to do |format|
      if @one_million_voice.save
        format.html { redirect_to @one_million_voice, notice: "Your questions have been registered" }
        format.json { render :show, status: :created, location: @one_million_voice }
      else
        format.html { render :new }
        format.json { render json: @one_million_voice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /one_million_voices/1 or /one_million_voices/1.json
  def update
    respond_to do |format|
      if @one_million_voice.update(one_million_voice_params)
        format.html { redirect_to one_million_voice_url(@one_million_voice), notice: "One million voice was successfully updated." }
        format.json { render :show, status: :ok, location: @one_million_voice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @one_million_voice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /one_million_voices/1 or /one_million_voices/1.json
  def destroy
    @one_million_voice.destroy

    respond_to do |format|
      format.html { redirect_to one_million_voices_url, notice: "One million voice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_one_million_voice
      if params[:local_id]
        local_id = Local.friendly.find(params[:local_id])
        @one_million_voice = OneMillionVoice.where(local_id: local_id).load_async.sort_by(&:updated_at).reverse.first
        puts @one_million_voice
      else
        @one_million_voice = OneMillionVoice.find(params[:id])
      end
    end

    # Only allow a list of trusted parameters through.
    def one_million_voice_params
      params.require(:one_million_voice).permit(:description, :problem_it_address, :how_it_is_done, :expected_function_effects, :local_id, :usuario_id, principles: [])
    end


    def load_local
      @local = Local.friendly.find(params[:local_id]) if params[:local_id]
    end

    def load_usuario
      @usuario = Usuario.friendly.find(params[:usuario_id]) if params[:usuario_id]
    end
end
