# frozen_string_literal: true

module ApplicationHelper
  def form_for_media(condition, &block)
    if condition["practice_id"]
      form_for [@practice, @media], html: { multipart: true }, &block
    elsif condition["location_id"]
      form_for [@location, @media], html: { multipart: true }, &block
    end
  end

  def title(*parts)
    content_for(:title) { (parts << t(:site_name)).join(" | ") } unless parts.empty?
  end
end
