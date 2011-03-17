module ApplicationHelper
  def title
    base_title = "Roomies makes living together easier"
    short_title = "Roomies"

    if @title.nil?
      base_title
    else
      "#{short_title} | #{@title}"
    end
  end
end
