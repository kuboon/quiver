module Quiver
  def self.local(path)
    adapter = Quiver::Adapter::Local.new(Pathname.new(path))
    Quiver::Root.new(adapter)
  end
  def self.dropbox(path, access_key)
    adapter = Quiver::Adapter::Dropbox.new(Pathname.new(path), access_key)
    Quiver::Root.new(adapter)
  end
end

require 'quiver_note/version'
require 'quiver/config'
require 'quiver/root'
require 'quiver/notebook'
require 'quiver/note'
require 'quiver/cell'
require 'quiver/adapter/local'
require 'quiver/adapter/dropbox'
