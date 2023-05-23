# frozen_string_literal: true

class PracticesController < ApplicationController
  before_action :authenticate_account!, only: %i[new edit update destroy]
  before_action lambda { check_owner Practice.friendly.find(params[:id]).account_id }, only: %i[edit update destroy]

  before_action :set_practice, only: %i[show edit update destroy]
  before_action :load_locations, except: %i[index show]
  before_action :load_location
  before_action :load_account
  before_action :load_options

  # GET /practices
  # GET /practices.json
  def index
    @practices = if params[:filter]
      if (params[:value] == "All") || (params[:value] == "Filter")
        Practice.order("updated_at DESC").load_async.order("practices.updated_at DESC").page(params[:page])
      else
        if params[:filter] == "components"
          Practice.joins(:characterise).where("food_system_components_addressed LIKE ?", "%#{params[:value]}%").load_async.order("practices.updated_at DESC").page(params[:page])
        elsif params[:filter] == "principles"
          Practice.joins(:characterise).where("agroecology_principles_addressed LIKE ?", "%#{params[:value]}%").load_async.order("practices.updated_at DESC").page(params[:page])
        end
      end
    else
      @practices = if params[:location_id]
        Practice.where(location_id: @location.id).load_async.sort_by(&:updated_at).reverse
      elsif params[:account_id]
        Practice.where(account_id: @account.id).load_async.sort_by(&:updated_at).reverse
      else
        Practice.order("updated_at DESC").load_async.page(params[:page])
      end
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
        "Filter by Components" => "Filter",
        "All" => "All",
        "Soil" => "Soil",
        "Water" => "Water",
        "Crops" => "Crops",
        "Livestock" => "Livestock",
        "Trees" => "Trees",
        "Pests" => "Pests",
        "Energy" => "Energy",
        "Household" => "Household",
        "Workers" => "Workers",
        "Community" => "Community",
        "Value chain" => "Value chain",
        "Policy" => "Policy",
        "Other" => "Other",
        "Whole Food System" => "Whole Food System",
        "I am not sure" => "I am not sure"
      }

      @agroecology_principles_addressed_options = {
        "Filter by Principles" => "Filter",
        "All" => "All",
        "Recycling" => "Recycling",
        "Input reduction" => "Input reduction",
        "Soil heath" => "Soil heath",
        "Animal health" => "Animal health",
        "Biodiversity" => "Biodiversity",
        "Synergy" => "Synergy",
        "Economic diversification" => "Economic diversification",
        "Co-creation of knowledge" => "Co-creation of knowledge",
        "Social values and diets" => "Social values and diets",
        "Fairness" => "Fairness",
        "Connectivity" => "Connectivity",
        "Land and natural resource governance" => "Land and natural resource governance",
        "Participation" => "Participation"
      }
    end
end
