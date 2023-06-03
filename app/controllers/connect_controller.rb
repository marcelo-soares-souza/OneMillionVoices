# frozen_string_literal: true

class ConnectController < ApplicationController
  before_action :load_system_options
  before_action :load_principles
  before_action :load_options_what_you_do
  before_action :load_options_acknowledges

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
    @practices = @practices.by_where_it_is_realized(params[:where_it_is_realized]) unless params[:where_it_is_realized].blank?
    @practices = @practices.by_knowledge_source(params[:knowledge_source]) unless params[:knowledge_source].blank?
    @practices = @practices.by_farm_and_farming_system(params[:system_functions]) unless params[:system_functions].blank?
    @practices = @practices.by_farm_and_farming_system_complement(params[:system_components]) unless params[:system_components].blank?
    @practices = @practices.by_country(params[:country]) unless params[:country].blank?
    @practices = @practices.by_continent(params[:continent]) unless params[:continent].blank?
    @practices = @practices.order("practices.updated_at DESC").page(params[:page])
  end
end