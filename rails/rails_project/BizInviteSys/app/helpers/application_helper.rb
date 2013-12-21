module ApplicationHelper
  #tonggle the sortable list
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column.to_s == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end
end
