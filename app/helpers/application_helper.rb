module ApplicationHelper
  def layout_class
    if hide_navbar? || (controller_name == "sites" && action_name == "index")
      "layout-default"   # landing page + auth pages without sidebars
    else
      "layout-three-column" # all other pages
    end
  end
end
