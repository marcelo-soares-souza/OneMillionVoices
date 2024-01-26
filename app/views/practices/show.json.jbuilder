# frozen_string_literal: true


json.id @practice.id
json.name @practice.name
json.location @practice.location.name
json.responsible_for_information @practice.account.name
json.url practice_url(@practice)
json.image_url photo_thumb_url(@practice)

# what_you_do
json.where_it_is_realized @practice.what_you_do.where_it_is_realized ? @practice.what_you_do.where_it_is_realized : ''
json.summary_description @practice.what_you_do.summary_description_of_agroecological_practice ? @practice.what_you_do.summary_description_of_agroecological_practice.truncate(512) : ""
json.practical_implementation_of_the_practice @practice.what_you_do.practical_implementation_of_the_practice ? @practice.what_you_do.practical_implementation_of_the_practice : ''
json.type_of_agroecological_practice @practice.what_you_do.type_of_agroecological_practice ? @practice.what_you_do.type_of_agroecological_practice : ''
json.why_you_use_and_what_you_expect_from_this_practice @practice.what_you_do.why_you_use_and_what_you_expect_from_this_practice ? @practice.what_you_do.why_you_use_and_what_you_expect_from_this_practice : ''
json.land_size @practice.what_you_do.land_size ? @practice.what_you_do.land_size : ''
json.substitution_of_less_ecological_alternative @practice.what_you_do.substitution_of_less_ecological_alternative ? @practice.what_you_do.substitution_of_less_ecological_alternative : ''

# characterise
json.agroecology_principles_addressed @practice.characterise.agroecology_principles_addressed ? @practice.characterise.agroecology_principles_addressed : ''
json.food_system_components_addressed @practice.characterise.food_system_components_addressed ? @practice.characterise.food_system_components_addressed : ''

json.created_at @practice.created_at
json.updated_at @practice.updated_at
