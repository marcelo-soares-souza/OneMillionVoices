# frozen_string_literal: true

class MidiasController < ApplicationController
  before_action :set_midia, only: %i[show edit update destroy]
  before_action :authenticate_usuario!, only: %i[new edit update destroy]
  before_action -> { check_owner Midia.friendly.find(params[:id]).usuario_id }, only: %i[edit update destroy]
  before_action :load_dados
  before_action :selected_id
  before_action :default_media_name

  # GET /midias
  # GET /midias.json
  def index
    if params[:agroecological_practice_id]
      @midias = Midia.where(agroecological_practice_id: @agroecological_practice.id).load_async
    elsif params[:experiencia_agroecologica_id]
      @midias = Midia.where(experiencia_agroecologica_id: @experiencia_agroecologica.id).load_async
    elsif params[:one_million_voice_id]
      @midias = Midia.where(one_million_voice_id: @one_million_voice.id).load_async
    elsif params[:local_id]
      @midias = Midia.where(local_id: @local.id).load_async
    end
  end

  # GET /gallery
  # GET /gallery.json
  def gallery
    if params[:agroecological_practice_id]
      @midias = Midia.where(agroecological_practice_id: @agroecological_practice.id).load_async
    elsif params[:experiencia_agroecologica_id]
      @midias = Midia.where(experiencia_agroecologica_id: @experiencia_agroecologica.id).load_async
    elsif params[:one_million_voice_id]
      @midias = Midia.where(one_million_voice_id: @one_million_voice.id).load_async
    elsif params[:local_id]
      @midias = Midia.where(local_id: @local.id).load_async
    end
  end

  # GET /midias/1
  # GET /midias/1.json
  def show; end

  # GET /midias/new
  def new
    @midia = Midia.new
  end

  # GET /midias/1/edit
  def edit; end

  # POST /midias
  # POST /midias.json
  def create
    @midia = Midia.new(midia_params)
    @midia.usuario_id = current_usuario.id unless current_usuario.admin?

    if params[:agroecological_practice_id]
      @midia.agroecological_practice_id = @agroecological_practice.id
    elsif params[:experiencia_agroecologica_id]
      @midia.experiencia_agroecologica_id = @experiencia_agroecologica.id
    elsif params[:one_million_voice_id]
      @midia.one_million_voice_id = @one_million_voice.id
      @midia.local_id = @one_million_voice.local_id
    elsif params[:local_id]
      @midia.local_id = @local.id
    end

    respond_to do |format|
      if @midia.save
        if params[:agroecological_practice_id]
          format.html { redirect_to agroecological_practice_midia_path(@agroecological_practice, @midia), notice: "Midia foi cadastrada." }
        elsif params[:experiencia_agroecologica_id]
          format.html do
            redirect_to experiencia_agroecologica_midia_path(@experiencia_agroecologica, @midia),
                        notice: "Midia foi cadastrada."
          end
        elsif params[:one_million_voice_id]
          format.html do
            redirect_to one_million_voice_gallery_path(@one_million_voice),  notice: "Photo Added."
          end
        elsif params[:local_id]
          format.html do
            redirect_to local_gallery_path(@local),  notice: "Photo Added."
          end
        end
        format.json { render :show, status: :created, location: @midia }
      else
        format.html { render :new }
        format.json { render json: @midia.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /midias/1
  # PATCH/PUT /midias/1.json
  def update
    respond_to do |format|
      if @midia.update(midia_params)
        if params[:agroecological_practice_id]
          format.html { redirect_to agroecological_practice_midia_path(@agroecological_practice, @midia), notice: "Media has been updated." }
        elsif params[:experiencia_agroecologica_id]
          format.html do
            redirect_to experiencia_agroecologica_midia_path(@experiencia_agroecologica, @midia),
                        notice: "Media has been updated."
          end
        elsif params[:one_million_voice_id]
          format.html do
            redirect_to one_million_voice_gallery_path(@one_million_voice),  notice: "Media has been updated."
          end
        elsif params[:local_id]
          format.html do
            redirect_to local_gallery_path(@local),  notice: "Media has been updated."
          end
        end
        format.json { render :show, status: :ok, location: @midia }
      else
        format.html { render :edit }
        format.json { render json: @midia.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /midias/1
  # DELETE /midias/1.json
  def destroy
    @midia.destroy

    respond_to do |format|
      if params[:agroecological_practice_id]
        format.html { redirect_to agroecological_practice_midias_path(@agroecological_practice), notice: "Media has been removed." }
      elsif params[:experiencia_agroecologica_id]
        format.html do
          redirect_to experiencia_agroecologica_midias_path(@experiencia_agroecologica), notice: "Media has been removed."
        end
      elsif params[:one_million_voice_id]
        format.html do
          redirect_to one_million_voice_gallery_path(@one_million_voice), notice: "Media has been removed."
        end
      elsif params[:local_id]
        format.html do
          redirect_to local_gallery_path(@local), notice: "Media has been removed."
        end
      end
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_midia
    @midia = Midia.friendly.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def midia_params
    params.require(:midia).permit(:descricao, :slug, :agroecological_practice_id, :experiencia_agroecologica_id, :imagem, :usuario_id)
  end

  def load_dados
    if params[:agroecological_practice_id]
      @agroecological_practice = AgroecologicalPractice.find(params[:agroecological_practice_id])
    elsif params[:experiencia_agroecologica_id]
      @experiencia_agroecologica = ExperienciaAgroecologica.friendly.find(params[:experiencia_agroecologica_id])
    elsif params[:one_million_voice_id]
      @one_million_voice = OneMillionVoice.find(params[:one_million_voice_id])
    elsif params[:local_id]
      @local = Local.friendly.find(params[:local_id])
    end
  end

  def selected_id
    if current_usuario && current_usuario.admin?
      @selected_id = current_usuario.id
      if @experiencia_agroecologica
        @selected_id = @experiencia_agroecologica.usuario.id
      elsif @agroecological_practice
        @selected_id = @agroecological_practice.usuario.id
      elsif @one_million_voice
        @selected_id = @one_million_voice.usuario.id
      elsif @local
        @selected_id = @local.usuario.id
      end
    end
  end

  def default_media_name
    @default_media_name = ""
    if @experiencia_agroecologica
      @default_media_name = @experiencia_agroecologica.nome + " "
    elsif @agroecological_practice
      @default_media_name = @agroecological_practice.local.nome + " "
    elsif @one_million_voice
      @default_media_name = @one_million_voice.local.nome + " "
    elsif @local
      @default_media_name = @local.nome + " "
    end
  end
end
