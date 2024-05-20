module VideosHelper
  def truncate_title(title, length = 55)
    if title.length > length
      truncated_title = title[0, length - 3] + '...'
    else
      truncated_title = title
    end
    return truncated_title
  end
end
