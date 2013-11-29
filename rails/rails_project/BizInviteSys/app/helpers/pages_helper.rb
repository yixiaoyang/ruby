module PagesHelper
  def full_title(page_title)
    base_title = "BizInvite.Ruby"
    if @page_title.empty?
      base_title
    else
      "#{base_title} | #{@page_title}"
    end
  end
end
