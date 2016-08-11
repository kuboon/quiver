# QuiverNote

Unofficial ruby interface for [HappenApps quiver](happenapps.com/#quiver)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quiver_note'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install quiver_note

## Usage

### example1: Read via dropbox
```ruby
root = Quiver.dropbox('/Quiver.qvlibrary', dropbox_access_token)
inbox = root.nobebook('inbox')
inbox.each do |note|
  puts note.title
end
```
### example2: Write to local storage
```ruby
root = Quiver.local('/home/kuboon/documents/Quiver.qvlibrary')
notebook = root.notebook('blog')

Entry.find_each do |entry|
  title = entry.title
  content = {title: title, cells: [{type: :markdown, data: get_markdown(entry)}]}
  note = Quiver::Note.new(content: content, meta: {title: title, created_at: entry.created_at.to_i, updated_at: entry.updated_at.to_i})
  notebook.add(note)
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/quiver/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
