# frozen_string_literal: true

json.id local.id
json.name local.name
json.description local.description
json.latitude local.latitude
json.longitude local.longitude
json.type @property_types.key(local.property_type)
json.logo_image_url asset_url(local.imagem.url(:medium))
json.responsible_for_information local.usuario.name
json.url local_url(local)
json.created_at local.created_at
json.updated_at local.updated_at
