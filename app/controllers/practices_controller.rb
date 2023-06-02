# frozen_string_literal: true

class PracticesController < ApplicationController
  before_action :authenticate_account!, only: %i[new edit update destroy]
  before_action lambda { check_owner Practice.friendly.find(params[:id]).account_id }, only: %i[edit update destroy]

  before_action :set_practice, only: %i[show edit update destroy]
  before_action :load_locations, except: %i[index show]
  before_action :load_location
  before_action :load_account
  before_action :load_options
  before_action :load_system_options
  before_action :load_locations, only: %i[new]

  # GET /practices
  # GET /practices.json
  def index
    @practices = if params[:filter]
      filter
    else
      all
    end
  end

  def all
    @practices = if params[:location_id]
      Practice.where(location_id: @location.id).load_async.sort_by(&:updated_at).reverse
    elsif params[:account_id]
      Practice.where(account_id: @account.id).load_async.sort_by(&:updated_at).reverse
    else
      Practice.order("updated_at DESC").load_async.page(params[:page])
    end
  end
  def filter
    @practices = Practice.unscoped
    @practices = @practices.by_name(params[:name]) unless params[:name].blank?
    @practices = @practices.by_food_system_components_addressed(params[:components]) unless params[:components].blank?
    @practices = @practices.by_agroecology_principles_addressed(params[:principles]) unless params[:principles].blank?
    @practices = @practices.by_farm_and_farming_system(params[:system_functions]) unless params[:system_functions].blank?
    @practices = @practices.by_farm_and_farming_system_complement(params[:system_components]) unless params[:system_components].blank?
    @practices = @practices.by_country(params[:country]) unless params[:country].blank?
    @practices = @practices.by_continent(params[:continent]) unless params[:continent].blank?
    @practices = @practices.page(params[:page])
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
    @practice.account_id = current_account.id unless current_account.admin?

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
      params.require(:practice).permit(:name, :photo, :slug, :location_id, :account_id)
    end

    def load_location
      @location = Location.friendly.find(params[:location_id]) if params[:location_id]
    end

    def load_account
      @account = Account.friendly.find(params[:account_id]) if params[:account_id]
    end

    def load_options
      @food_system_components_addressed_options = {
        # "Filter by System Component" => "Filter",
        # "All" => "All",
        "1 - Soil" => "Soil",
        "2 - Water" => "Water",
        "3 - Crops" => "Crops",
        "4 - Livestock" => "Livestock",
        "5 - Trees" => "Trees",
        "6 - Pests" => "Pests",
        "7 - Energy" => "Energy",
        "8 - Household" => "Household",
        "9 - Workers" => "Workers",
        "10 - Community" => "Community",
        "11 - Value chain" => "Value chain",
        "12 - Policy" => "Policy",
        "13 - Whole Food System" => "Whole Food System",
        "14 - Other" => "Other",
        "15 - I am not sure" => "I am not sure"
      }

      @agroecology_principles_addressed_options = {
        # "Filter by Agroecology Principle" => "Filter",
        # "All" => "All",
        "1 - Recycling" => "Recycling",
        "2 - Input reduction" => "Input reduction",
        "3 - Soil health" => "Soil health",
        "4 - Animal health" => "Animal health",
        "5 - Biodiversity" => "Biodiversity",
        "6 - Synergy" => "Synergy",
        "7 - Economic diversification" => "Economic diversification",
        "8 - Co-creation of knowledge" => "Co-creation of knowledge",
        "9 - Social values and diets" => "Social values and diets",
        "10 - Fairness" => "Fairness",
        "11 - Connectivity" => "Connectivity",
        "12 - Land and natural resource governance" => "Land and natural resource governance",
        "13 - Participation" => "Participation"
      }
    end
end
