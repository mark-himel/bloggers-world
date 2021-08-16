class BlogManager
  attr_accessor :blog_id, :params

  def initialize(blog_id = nil, params = nil)
    @blog_id = blog_id
    @params = params
  end

  def self.get_list
    new.get_list
  end

  def self.get_blog(blog_id)
    new(blog_id).get_blog
  end

  def self.get_comments(blog_id)
    new(blog_id).get_comments
  end

  def self.post_comment(blog_id, params)
    new(blog_id, params).post_comment
  end

  def self.post_blog(params)
    new(nil, params).post_blog
  end

  def get_list
    url = "#{ENV['BLOG_SERVER_BASE_URL']}/posts"
    JSON.parse(RestClient.get(url, headers))['posts']
  rescue
    []
  end

  def get_blog
    url = "#{ENV['BLOG_SERVER_BASE_URL']}/posts/#{blog_id}"
    JSON.parse(RestClient.get(url, headers))
  rescue
    nil
  end

  def get_comments
    url = "#{ENV['BLOG_SERVER_BASE_URL']}/posts/#{blog_id}/comments"
    JSON.parse(RestClient.get(url, headers))['comments']
  rescue
    []
  end

  def post_comment
    url = "#{ENV['BLOG_SERVER_BASE_URL']}/posts/#{blog_id}/comments"
    JSON.parse(RestClient.post(url, payload_for_comment, headers).body)
  rescue
    nil
  end

  def post_blog
    url = "#{ENV['BLOG_SERVER_BASE_URL']}/posts"
    JSON.parse(RestClient.post(url, payload_for_blog, headers).body)
  rescue
    nil
  end

  def headers
    {
      content_type: :json,
      accept: :json
    }
  end

  def payload_for_comment
    {
      comment: {
        name: params[:name],
        body: params[:body],
        post_id: params[:post_id]
      }
    }.to_json
  end

  def payload_for_blog
    {
      post: {
        title: params[:title],
        body: params[:body]
      }
    }.to_json
  end
end