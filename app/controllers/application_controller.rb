# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  rescue_from ActionController::InvalidAuthenticityToken, with: :rescue_invalid_authenticity_token

  protected
    def set_locale
      default_locale = "en"
      I18n.default_locale = default_locale
      I18n.locale = params[:locale] || I18n.default_locale
      Rails.application.routes.default_url_options[:locale] = I18n.locale

      ISO3166.configure do |config|
        config.locales = [:en, :pt_BR, :es, :fr]
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :i_agree_with_terms_and_conditions])
    end

    def check_owner(account_id)
      if signed_in? && (!current_account.admin? && current_account.id != (account_id))
        redirect_to root_url, alert: t(:permission_denied)
      end
    end

    def check_owner_or_collaborator(account_id, collaborators)
      if signed_in? && (!current_account.admin? && current_account.id != account_id && !collaborators.collect(&:account_id).include?(current_account.id))
        redirect_to root_url, alert: t(:permission_denied)
      end
    end

    def check_if_admin
      redirect_to root_url, alert: t(:permission_denied) if signed_in? && !current_account.admin?
    end

    def load_locations
      @locations = if current_account.admin?
        Location.all
      else
        Location.where(account_id: current_account.id)
      end
    end

    def rescue_invalid_authenticity_token
      redirect_to "/422"
    end

    def load_yes_no_i_am_not_sure_options
      @yes_no_i_am_not_sure_options = {
        "1 - " + t(:yes_query) => "Yes",
        "2 - " + t(:no_query) => "No",
        "3 - " + t(:i_am_not_sure) => "I am not sure",
      }

      @yes_no_i_am_not_sure_not_applicable_options = {
        "1 - " + t(:yes_query) => "Yes",
        "2 - " + t(:no_query) => "No",
        "3 - " + t(:i_am_not_sure) => "I am not sure",
        t(:not_applicable) => "Not applicable"
      }
    end

    def load_effective_options
      @effective_options = {
        "5 - " + t(:very_effective) => "Very effective",
        "4 - " + t(:rather_effective) => "Rather effective",
        "3 - " + t(:neither_effective_nor_uneffective) => "Neither effective nor uneffective",
        "2 - " + t(:rather_uneffective) => "Rather uneffective",
        "1 - " + t(:very_uneffective) => "Very uneffective",
        "0 - " + t(:i_am_not_sure) => "I am not sure",
        t(:not_applicable) => "Not applicable"
      }
    end

    def load_system_options
      @system_functions_options = {
        # "Filter by Farm Functions" => "Filter",
        # "All" => "All",
        "1 - " + t(:mainly_home_consumption) => "Mainly Home Consumption",
        "2 - " + t(:mixed_home_consumption_and_commercial) => "Mixed Home Consumption and Commercial",
        "3 - " + t(:mainly_commercial) => "Mainly commercial",
        "4 - " + t(:other) => "Other",
        "5 - " + t(:i_am_not_sure) => "I Am not Sure"
      }

      @system_components_options = {
        # "Filter by Farm Components" => "Filter",
        # "All" => "All",
        "1 - " + t(:crops) => "Crops",
        "2 - " + t(:animals) => "Animals",
        "3 - " + t(:trees) => "Trees",
        "4 - " + t(:other) => "Other",
      }

      @continent_options = {
        # "Filter by Continent" => "Filter",
        # "All" => "All",
        "Africa" => "Africa",
        "Asia" => "Asia",
        "Europe" => "Europe",
        "North America" => "North America",
        "South America" => "South America",
        "Australia/Oceania" => "Australia",
        "Antarctica" => "Antarctica"
      }
    end

    def load_principles
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


    def load_options_what_you_do
      @where_it_is_realized_options = {
        "1 - " + "On-farm" => "On-farm",
        "2 - " + "Off-farm" => "Off-farm",
        "3 - " + "Other" => "Other"
      }

      @unit_of_measure_options = {
        "m2" => "m2",
        "Acre" => "Acre",
        "Hectare" => "Hectare",
        "Square foot" => "Square foot",
        t(:not_applicable) => "Not applicable"
      }
    end

  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:account, request.fullpath)
    end
end
