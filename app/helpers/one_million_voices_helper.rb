# frozen_string_literal: true

module OneMillionVoicesHelper
  def checked(area)
    @one_million_voice.principles.nil? ? false : @one_million_voice.principles.match(area)
  end
end
