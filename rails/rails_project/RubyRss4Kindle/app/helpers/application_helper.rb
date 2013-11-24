module ApplicationHelper
  # return a tile on per-page basic
  def title
    base_title = "RSS4Kindle.Ruby"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
