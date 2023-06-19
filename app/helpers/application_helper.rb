# frozen_string_literal: true

module ApplicationHelper
  def default_image_number
    rand(0..5)
  end
  def photo_thumb(entity, description = "")
    description || ""
    if entity.photo.attached?
      image_tag entity.photo.variant(:thumb), title: description, alt: description, class: "img-fluid"
    else
      name = "place"
      number = default_image_number

      if entity.class.to_s == "Account"
        name = "avatar"
        number = rand(0..9)
      end

      image_tag "/assets/#{name}_thumb_#{number}.png", title: description, alt: description
    end
  end
  def photo_medium(entity, description = "")
    description || ""
    if entity.photo.attached?
      image_tag entity.photo.variant(:medium), title: description, alt: description, class: "img-fluid"
    else
      image_tag "/assets/place_medium_#{default_image_number}.png", title: description, alt: description
    end
  end

  def photo_original(entity, description = "")
    description || ""
    if entity.photo.attached?
      image_tag entity.photo.variant(:original), title: description, alt: description, class: "img-fluid"
    else
      image_tag "/assets/place_medium_#{default_image_number}.png", title: description, alt: description
    end
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
