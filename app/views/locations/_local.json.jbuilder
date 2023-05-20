# frozen_string_literal: true

json.id location.id
json.name location.name
json.description location.description
json.latitude location.latitude
json.longitude location.longitude
json.type @property_types.key(location.property_type)
json.logo_image_url asset_url(location.photo.url(:medium))
json.responsible_for_information location.account.name
json.url location_url(location)
json.created_at location.created_at
json.updated_at location.updated_at
