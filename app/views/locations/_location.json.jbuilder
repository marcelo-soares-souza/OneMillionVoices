# frozen_string_literal: true

json.id location.id
json.name location.name
json.country location.country
json.farm_and_farming_system location.farm_and_farming_system
json.description location.description
json.latitude location.latitude if not location.hide_my_location
json.longitude location.longitude if not location.hide_my_location
json.responsible_for_information location.account.name
json.url location_url(location)
json.created_at location.created_at
json.updated_at location.updated_at
