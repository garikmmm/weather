module ApplicationHelper
  def nav_links
    items = [home_link, home_link_with_react]
    content_tag :ul, :class => "nav navbar-nav" do
      items.collect { |item| concat item}
    end
  end

  def nav_item_active_if(condition, attributes = {}, &block)
    if condition
      attributes["class"] = "active"
    end
    content_tag(:li, attributes, &block)
  end

  def home_link
    nav_item_active_if(current_page?(controller: 'weather', action: 'index')) do
      link_to "Home", root_path
    end
  end

  def home_link_with_react
    nav_item_active_if(current_page?(controller: 'weather', action: 'index_react')) do
      link_to "Home - React", 'home_react'
    end
  end
end
