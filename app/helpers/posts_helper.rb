module PostsHelper
  def formatted_post_text(post, options = { truncate: false })
    formatted_text = post.text

    if options[:truncate]
      formatted_text = truncate(post.text, length: 600, separator: ' ') do
        link_to ' Read more', blog_post_path(post.author.name, post)
      end
    end

    simple_format(formatted_text)
  end
end
