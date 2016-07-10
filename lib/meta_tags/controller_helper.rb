module MetaTags
  # Contains methods to use in controllers.
  #
  # You can define several instance variables to set meta tags:
  #   @page_title = 'Member Login'
  #   @page_description = 'Member login page.'
  #   @page_keywords = 'Site, Login, Members'
  #
  # Also you can use {#set_meta_tags} method, that have the same parameters
  # as {ViewHelper#set_meta_tags}.
  #
  module ControllerHelper
    protected

    # Processes the <tt>@page_title</tt>, <tt>@page_keywords</tt>, and
    # <tt>@page_description</tt> instance variables and calls +render+.
    def render(*)
      self.meta_tags[:title]       = @page_title       if @page_title
      self.meta_tags[:keywords]    = @page_keywords    if @page_keywords
      self.meta_tags[:description] = @page_description if @page_description

      super
    end

    # Set meta tags for the page.
    #
    # See <tt>MetaTags::ViewHelper#set_meta_tags</tt> for details.
    def set_meta_tags(meta_tags)
      self.meta_tags.update(meta_tags)
    end

    # Get meta tags for the page.
    def meta_tags
      @meta_tags ||= MetaTagsCollection.new
    end
  end
end
