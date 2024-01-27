json.gallery do
  json.array!(@practice.medias) do |media|
      json.description media.description
      json.image_url photo_thumb_url(media)
  end
end

