# frozen_string_literal: true

class PracticesController < ApplicationController
  before_action :authenticate_account!, only: %i[new edit update destroy like]
  before_action lambda { check_owner Practice.friendly.find(params[:id]).account_id }, only: %i[edit update destroy]

  before_action :set_practice, only: %i[show edit update destroy]
  before_action :load_locations, except: %i[index show]
  before_action :load_location
  before_action :load_account
  before_action :load_principles
  before_action :load_system_options
  before_action :load_locations, only: %i[new]
  before_action :load_likes_info, only: %i[show]

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
    @practices = @practices.order("practices.updated_at DESC").page(params[:page])
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

  def like
    @practice = Practice.friendly.find(params[:id])
    Like.create(account_id: current_account.id, practice_id: @practice.id)
    redirect_to @practice
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

    def load_likes_info
      likes = @practice.likes.map { |like| like.account.name }.join(", ")
      @likes_info = likes.empty? ? "Like Button" : likes
    end
end
