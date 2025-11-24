module ApplicationHelper
  def layout_class
    if controller_name == "sites" && action_name == "index"
      "layout-default"   # landing page
    else
      "layout-three-column" # all other pages
    end
  end
end
