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
    if params[:practice_id]
      @midias = Midia.where(practice_id: @practice.id).load_async
    elsif params[:local_id]
      @midias = Midia.where(local_id: @local.id).load_async
    end
  end

  # GET /gallery
  # GET /gallery.json
  def gallery
    if params[:practice_id]
      @midias = Midia.where(practice_id: @practice.id).load_async
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

    if params[:practice_id]
      @midia.practice_id = @practice.id
      @midia.local_id = @practice.local.id
    elsif params[:local_id]
      @midia.local_id = @local.id
    end

    respond_to do |format|
      if @midia.save
        if params[:practice_id]
          format.html { redirect_to practice_gallery_path(@practice, @midia), notice: "Photo has been sent" }
        elsif params[:local_id]
          format.html do
            redirect_to local_gallery_path(@local),  notice: "Photo has been sent"
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
        if params[:practice_id]
          format.html { redirect_to practice_gallery_path(@practice, @midia), notice: "Media has been updated." }
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
      if params[:practice_id]
        format.html { redirect_to practice_path(@practice), notice: "Media has been removed." }
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
      params.require(:midia).permit(:descricao, :slug, :practice_id, :local_id, :imagem, :usuario_id)
    end

    def load_dados
      if params[:practice_id]
        @practice = AgroecologicalPractice.find(params[:practice_id])
      elsif params[:local_id]
        @local = Local.friendly.find(params[:local_id])
      end
    end

    def selected_id
      if current_usuario && current_usuario.admin?
        @selected_id = current_usuario.id
        if @practice
          @selected_id = @practice.usuario.id
        elsif @local
          @selected_id = @local.usuario.id
        end
      end
    end

    def default_media_name
      @default_media_name = ""

      if @practice
        @default_media_name = "Agroecological Practice in " + @practice.local.nome + " "
      elsif @local
        @default_media_name = "Location " + @local.nome + " "
      end
    end
end
