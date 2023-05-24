# frozen_string_literal: true

module ApplicationHelper
  def default_image_number
    rand(0..5)
  end
  def photo_thumb(entity, description = "")
    description || ""
    if entity.photo.attached?
      image_tag entity.photo.variant(:thumb), title: description, alt: description
    else
      image_tag "/assets/place_thumb_#{default_image_number}.png"
    end
  end
  def photo_medium(entity, description = "")
    description || ""
    image_tag entity.photo.variant(:medium), title: description, alt: description
  end

  def photo_original(entity, description = "")
    description || ""
    image_tag entity.photo.variant(:original), title: description, alt: description
  end

  def form_for_media(condition, &block)
    if condition["practice_id"]
      form_for [@practice, @media], html: { multipart: true }, &block
    elsif condition["location_id"]
      form_for [@location, @media], html: { multipart: true }, &block
    end
  end

  def form_for_document(condition, &block)
    if condition["practice_id"]
      form_for [@practice, @document], html: { multipart: true }, &block
    elsif condition["location_id"]
      form_for [@location, @document], html: { multipart: true }, &block
    end
  end
  def title(*parts)
    content_for(:title) { (parts << t(:site_name)).join(" | ") } unless parts.empty?
  end
end
