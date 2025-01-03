# frozen_string_literal: true

json.id @location.id
json.name @location.name
json.country @location.country ? ISO3166::Country[@location.country].iso_short_name : ""
json.country_code @location.country || ""
json.is_it_a_farm @location.is_it_a_farm
json.farm_and_farming_system_complement @location.farm_and_farming_system_complement || ""
json.farm_and_farming_system @location.farm_and_farming_system || ""
json.farm_and_farming_system_details @location.farm_and_farming_system_details || ""
json.what_is_your_dream @location.what_is_your_dream || ""
json.image_url photo_thumb_url(@location, "", true)
json.description @location.description || ""
json.hide_my_location @location.hide_my_location || false
json.latitude  @location.latitude.round(5)
json.longitude @location.longitude.round(5)
json.responsible_for_information @location.account.name
json.url location_url(@location)
json.account_id @location.account_id
json.created_at @location.created_at
json.updated_at @location.updated_at
