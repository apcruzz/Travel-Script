module SitesHelper
  def title(page_title, show_title = true)
    content_for(:title) { page_title.to_s }
    @show_title = show_title
  end

  # def nav_link(text, path) BROTHER SLADES NAVIGATION
  #   if current_page?(path)
  #     content_tag(:li, class: "nav-item") do
  #       link_to(text, path, class: "nav-link active", aria: { current: "page" })
  #     end
  #   else
  #     content_tag(:li, class: "nav-item") do
  #       link_to(text, path, class: "nav-link")
  #     end
  #   end
  # end
  #
  def nav_link(path, text = nil, **options, &block)
    active_class = current_page?(path) ? "active" : ""
    options[:class] = [ "nav-link", active_class, options[:class] ].compact.join(" ")

    content_tag(:li, class: "nav-item") do
      if block_given?
        link_to(path, options, &block)
      else
        link_to(text, path, options)
      end
    end
  end
end
