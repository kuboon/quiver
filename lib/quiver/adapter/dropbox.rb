require 'dropbox_api' rescue nil

if defined? ::DropboxApi

module Quiver
  module Adapter
    class Dropbox
      def initialize(root, access_key)
        @root = root
        @access_key = access_key
      end
      def client
        @client ||= ::DropboxApi::Client.new(@access_key)
      end

      # Don't include this url direct on your site. Use via cdn.
      def image_url(path)
        @@image_url_cache ||= {}
        @@image_url_cache[path] ||= client.get_temporary_link(normalize_path(path)).link
      end
      def each(path)
        dir_metadata = client.get_metadata(normalize_path(path))
        dir_metadata['contents'].each do |content|
          next unless content['is_dir']
          yield Pathname.new(content['path'])
        end
      end
      def load(path)
        content = nil
        meta = client.download(normalize_path(path)) do |con|
          content = con
        end
        [content, meta]
      end
      def save(path, content)
        client.upload normalize_path(path), content
      end

      private

      def normalize_path(path)
        @root.join(path).to_s
      end
    end
  end
end

end # ::DropboxApi
