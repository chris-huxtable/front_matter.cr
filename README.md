# front_matter.cr

Separates a files front matter from its content. Unlike Jekyll and others this implementation is format agnostic.


## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  front_matter:
    github: chris-huxtable/front_matter.cr
```


## Usage

```crystal
require "front_matter"
```

To process a file:

```crystal
FrontMatter.open("/path/to/file") { |front_matter, content_io|

	# Do something with the front matter and content.
	# Parse the frontmatter as YAML, JSON or something else?

}
```

Alternatively you can parse an `IO` so long as it supports the `#.seek` method
```crystal
File.open(filename, "r") { |fd|
	FrontMatter.parse(fd) { |front_matter, content_io|

		# Do something with the front matter and content.
		# Parse the front matter as YAML, JSON or something else?

	}
}
```

A file containing front matter is broken into two sections; the front matter, and the content. The front matter is
contained between a two lines containing `---` and is located at the very start of a file.
```
---
This is the frontmatter
---

This is the content
```


## Contributing

1. Fork it ( https://github.com/chris-huxtable/front_matter.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request


## Contributors

- [Chris Huxtable](https://github.com/chris-huxtable) - creator, maintainer
