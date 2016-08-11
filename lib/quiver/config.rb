require 'active_support/configurable'

module Quiver
  #   Quiver.configure do |config|
  #     config.markdown_renderer = ->(markdown){ MyRenderer.render(markdown) }
  #   end
  def self.configure(&block)
    yield @config ||= Quiver::Configuration.new
  end

  # Global settings for Quiver
  def self.config
    @config
  end

  class Configuration #:nodoc:
    include ActiveSupport::Configurable
    config_accessor :markdown_renderer
  end

  configure do |config|
    config.markdown_renderer = ->(markdown){
      raise 'please configure your markdown renderer or add gem "redcarpet".' unless defined? Redcarpet
      @@redcarpet ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, strikethrough: true, fenced_code_blocks: true, tables: true, autolink: true)
      @@redcarpet.render(markdown)
    }
  end
end
