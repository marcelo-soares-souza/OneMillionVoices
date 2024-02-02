# frozen_string_literal: true

json.id @location.id
json.name @location.name
json.country @location.country ? ISO3166::Country[@location.country].iso_short_name : ""
json.is_it_a_farm @location.is_it_a_farm || true
json.farm_and_farming_system_complement @location.farm_and_farming_system_complement || ""
json.farm_and_farming_system @location.farm_and_farming_system || ""
json.farm_and_farming_system_details @location.farm_and_farming_system_details || ""
json.what_is_your_dream @location.what_is_your_dream || ""
json.image_url photo_thumb_url(@location)
json.description @location.description || ""
json.hide_my_location @location.hide_my_location || false
json.latitude @location.latitude if not @location.hide_my_location
json.longitude @location.longitude if not @location.hide_my_location
json.responsible_for_information @location.account.name
json.url location_url(@location)
json.created_at @location.created_at
json.updated_at @location.updated_at
