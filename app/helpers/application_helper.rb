# frozen_string_literal: true

module ApplicationHelper
  def form_for_midia(condition, &block)
    if condition["saf_id"]
      form_for [@saf, @midia], html: { multipart: true }, &block
    elsif condition["experiencia_agroecologica_id"]
      form_for [@experiencia_agroecologica, @midia], html: { multipart: true }, &block
    elsif condition["one_million_voice_id"]
      form_for [@one_million_voice, @midia], html: { multipart: true }, &block
    elsif condition["local_id"]
      form_for [@local, @midia], html: { multipart: true }, &block
    end
  end

  def form_for_blog(condition, &block)
    form_for [@local, @blog], html: { multipart: true }, &block if condition
  end

  def title(*parts)
    content_for(:title) { (parts << t(:site_name)).join(" | ") } unless parts.empty?
  end
end
