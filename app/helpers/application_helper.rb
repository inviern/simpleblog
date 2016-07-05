module ApplicationHelper
  def default_title
    'Simpleblog'
  end

  class MyLinkRenderer < WillPaginate::ActionView::BootstrapLinkRenderer
    def html_container(html)
      tag :ul, html, :class => "pager"
    end

    def previous_page
      num = @collection.current_page > 1 && @collection.current_page - 1
      previous_or_next_page(num, @options[:previous_label], 'previous')
    end

    def next_page
      num = @collection.current_page < total_pages && @collection.current_page + 1
      previous_or_next_page(num, @options[:next_label], 'next')
    end

    def previous_or_next_page(page, text, classname)

      tag :li,
          page ? link(text, page || '#') : (tag :span, text),
          :class => [classname, ('disabled' unless page)].join(' ')
    end
  end
end
