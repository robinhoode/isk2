module ApplicationHelper
  def available_copies(title)
    c = title.available_copies.count
    if c.zero?
      %Q{<span style="color: red">None</span>}.html_safe
    else
      %Q{<span style="color: green">#{c}</span>}.html_safe
    end
  end

  def authors(title)
    title.authors.map {|a| link_to a.author_name, author_path(a) }.join(", ").html_safe
  end
end
