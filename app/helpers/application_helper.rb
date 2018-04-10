module ApplicationHelper
  def form_for_midia(condition, &block)
    if condition
      form_for [@saf, @midia], html: { multipart: true }, &block
    else
      form_for [@experiencia_agroecologica, @midia], html: { multipart: true }, &block
    end
  end

  def form_for_blog(condition, &block)
    if condition
      form_for [@local, @blog], html: { multipart: true }, &block
    end
  end
end
