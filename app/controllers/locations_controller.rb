# frozen_string_literal: true

class LocationsController < ApplicationController
  before_action :set_location, only: %i[show edit update destroy]
  before_action :authenticate_account!, only: %i[new edit update destroy]
  before_action -> { check_owner Location.friendly.find(params[:id]).account_id }, only: %i[edit update destroy]
  before_action :load_account
  before_action :load_all_accounts, except: %i[index show]
  before_action :load_total_medias, only: %i[show]
  before_action :load_options
  before_action :load_system_options
  before_action :load_total

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
      Location.includes(:account, :practices).order("updated_at DESC").with_attached_photo.load_async.page(params[:page])
    end
  end

  def filter
    @locations = Location.unscoped
    @locations = @locations.includes(:practices)
    @locations = @locations.by_name(params[:name]) unless params[:name].blank?
    @locations = @locations.by_farm_and_farming_system(params[:system_functions]) unless params[:system_functions].blank?
    @locations = @locations.by_farm_and_farming_system_complement(params[:system_components]) unless params[:system_components].blank?
    @locations = @locations.by_country(params[:country]) unless params[:country].blank?
    @locations = @locations.by_continent(params[:continent]) unless params[:continent].blank?
    @locations = @locations.with_attached_photo
    @total = @locations.count
    @locations = @locations.order("locations.updated_at DESC").page(params[:page])
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
        format.html { redirect_to new_location_practice_path(@location), notice: t(:location_has_been_registered) }
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

  def coordinates
    @location = Geocoder.search(params[:country].blank? ? "Brazil" : params[:country])
  end

  def countries
    @countries = ISO3166::Country.find_all_countries_by_continent(params[:continent]).map(&:alpha2)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :slug, :country, :description, :farm_and_farming_system,
                                       :farm_and_farming_system_details, :what_is_your_dream, :latitude, :longitude, :account_id,
                                       :photo, :hide_my_location, :is_it_a_farm,
                                       account_ids: [], farm_and_farming_system_complement: [])
    end

    def load_all_accounts
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
        "1 - " + t(:mainly_home_consumption) => "Mainly Home Consumption",
        "2 - " + t(:mixed_home_consumption_and_commercial) => "Mixed Home Consumption and Commercial",
        "3 - " + t(:mainly_commercial) => "Mainly commercial",
        "4 - " + t(:other) => "Other",
        "5 - " + t(:i_am_not_sure) => "I am not sure"
      }
    end

    def load_total
      @total = Location.count
    end
end
