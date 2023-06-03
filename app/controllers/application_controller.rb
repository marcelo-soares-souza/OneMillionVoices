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

  private
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:account, request.fullpath)
    end
end
