# frozen_string_literal: true

module ApplicationHelper
  def form_for_midia(condition, &block)
    if condition["agroecological_practice_id"]
      form_for [@agroecological_practice, @midia], html: { multipart: true }, &block
    elsif condition["one_million_voice_id"]
      form_for [@one_million_voice, @midia], html: { multipart: true }, &block
    elsif condition["local_id"]
      form_for [@local, @midia], html: { multipart: true }, &block
    end
  end

  def title(*parts)
    content_for(:title) { (parts << t(:site_name)).join(" | ") } unless parts.empty?
  end
end
