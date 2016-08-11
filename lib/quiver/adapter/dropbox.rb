require 'dropbox_sdk'
module Quiver
  module Adapter
    class Dropbox
      def initialize(root, access_key)
        @root = root
        @access_key = access_key
      end
      def client
        @client ||= ::DropboxClient.new(@access_key)
      end

      # Don't include this url direct on your site. Use via cdn.
      def image_url(path)
        @@image_url_cache ||= {}
        @@image_url_cache[path] ||= client.media(normalize_path(path))['url']
      end
      def each(path)
        dir_metadata = client.metadata(normalize_path(path))
        dir_metadata['contents'].each do |content|
          next unless content['is_dir']
          yield Pathname.new(content['path'])
        end
      end
      def load(path)
        client.get_file normalize_path(path)
      end
      def save(path, content)
        client.put_file normalize_path(path), content
      end

      private

      def normalize_path(path)
        @root.join(path).to_s
      end
    end
  end
end
