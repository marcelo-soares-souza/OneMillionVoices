# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]
  before_action :authenticate_account!, only: %i[new edit update destroy]
  before_action -> { check_owner Location.friendly.find(params[:id]).account_id }, only: %i[edit update destroy]
  before_action :load_property_types
  before_action :load_account
  before_action :load_colaboradores, except: %i[index show]
  before_action :load_total_medias, only: %i[show]
  before_action :load_options

  # GET /locations
  # GET /locations.json
  def index
    @locations = if params[:filter]
      filter
    else
      all
    end
  end

  def all
    if params[:account_id]
      Location.where(account_id: @account.id).includes(:medias, :practices).load_async.sort_by(&:updated_at).reverse
    else
      Location.order("updated_at DESC").load_async.page(params[:page])
    end
  end

  def filter
    if (params[:value] == "All") || (params[:value] == "Filter")
      Location.order("updated_at DESC").load_async.page(params[:page])
    else
      if params[:filter] == "system"
        Location.where("farm_and_farming_system LIKE ? OR farm_and_farming_system_complement LIKE ?", "%#{params[:value]}%", "%#{params[:value]}%").load_async.order("updated_at DESC").page(params[:page])
      elsif params[:filter] == "search"
        Location.where("name ILIKE ?", "%#{params[:value]}%").load_async.order("updated_at DESC").page(params[:page])
      end
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show; end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    @location.account_id = current_account.id unless current_account.admin?

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: t(:location_has_been_registered) }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: t(:location_has_been_updated) }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: "Location has been removed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :slug, :country, :description, :farm_and_farming_system, :farm_and_farming_system_complement, :agroecology_in_practice, :summary_observation,
                                       :farm_and_farming_system_details, :latitude, :longitude, :account_id, :photo, :property_type, :hide_my_location, account_ids: [])
    end

    def load_property_types
      @property_types = {
        t(:settlement) => "Assentamento",
        t(:collective_property) => "Propriedade Coletiva",
        t(:public_property) => "Propriedade Pública (Governo)",
        t(:private_property) => "Propriedade Privada",
        t(:familiar) => "Familiar",
        t(:other) => "Outro"
      }
    end

    def load_colaboradores
      @accounts = Account.all.load_async
    end

    def load_account
      @account = Account.friendly.find(params[:account_id]) if params[:account_id]
    end

    def load_total_medias
      @total_media = Media.where(location_id: @location.id).count
    end

    def load_options
      @farm_and_farming_system_options = {
        "1 - " + t(:mainly_subsistence) => "Mainly subsistence",
        "2 - " + t(:mixed_subsistence_and_commercial) => "Mixed subsistence and commercial",
        "3 - " + t(:mainly_commercial) => "Mainly commercial",
        "4 - " + t(:other) => "Other",
        "5 - " + t(:i_am_not_sure) => "I am not sure"
      }

      @farm_and_farming_system_complement_options = {
        "1 - " + t(:mainly_crop_farming) => "Mainly crop farming",
        "2 - " + t(:mixed_crop_livestock_farming) => "Mixed crop-livestock farming",
        "3 - " + t(:mainly_livestock_farming) => "Mainly livestock farming",
        "4 - " + t(:other) => "Other",
        "5 - " + t(:i_am_not_sure) => "I Am Not Sure"
      }

      @system_options = {
        "Filter by Farm System" => "Filter",
        "All" => "All",
        t(:mainly_subsistence) => "Mainly subsistence",
        t(:mixed_subsistence_and_commercial) => "Mixed subsistence and commercial",
        t(:mainly_commercial) => "Mainly commercial",
        t(:mainly_crop_farming) => "Mainly crop farming",
        t(:mixed_crop_livestock_farming) => "Mixed crop-livestock farming",
        t(:mainly_livestock_farming) => "Mainly livestock farming",
        t(:other) => "Other",
        t(:i_am_not_sure) => "I Am Not Sure"
      }
    end
end
