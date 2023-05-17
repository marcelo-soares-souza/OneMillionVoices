# frozen_string_literal: true

module PracticesHelper
  def checked_practices(area)
    @practice.principles.nil? ? false : @practice.principles.match(area)
  end
end
