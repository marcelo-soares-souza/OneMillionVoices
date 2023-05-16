# frozen_string_literal: true

json.extract! agroecological_practice, :id, :usuario_id, :local_id, :summary_description, :problem_it_address, :how_it_is_done, :expected_function_effects, :principles, :general_evaluate, :created_at, :updated_at
json.url agroecological_practice_url(agroecological_practice, format: :json)
