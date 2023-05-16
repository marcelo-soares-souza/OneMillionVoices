# frozen_string_literal: true

module AgroecologicalPracticesHelper
  def checked_agroecological_practices(area)
    @agroecological_practice.principles.nil? ? false : @agroecological_practice.principles.match(area)
  end
end
