module BlogsHelper
  def generate_short_url(blog)
    url = request.host_with_port
    Shortener::ShortenedUrl.generate("http://#{url}/blog/#{blog.id}", owner: blog)
  end

  def display_short_url(blog)
    host = request.host_with_port
    key = blog.shortened_urls.last.unique_key
    "http://#{host}/#{key}"
  end
end
