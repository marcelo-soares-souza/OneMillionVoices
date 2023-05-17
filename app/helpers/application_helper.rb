# frozen_string_literal: true

module ApplicationHelper
  def form_for_midia(condition, &block)
    if condition["practice_id"]
      form_for [@practice, @midia], html: { multipart: true }, &block
    elsif condition["local_id"]
      form_for [@local, @midia], html: { multipart: true }, &block
    end
  end

  def title(*parts)
    content_for(:title) { (parts << t(:site_name)).join(" | ") } unless parts.empty?
  end
end
