# front_matter.cr

[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://chris-huxtable.github.io/front_matter.cr/)
[![GitHub release](https://img.shields.io/github/release/chris-huxtable/front_matter.cr.svg)](https://github.com/chris-huxtable/front_matter.cr/releases)
[![Build Status](https://travis-ci.org/chris-huxtable/front_matter.cr.svg?branch=master)](https://travis-ci.org/chris-huxtable/front_matter.cr)

Separates a files front matter from its content. Unlike Jekyll and others this implementation is format agnostic.

## Front Matter?

Front matter is metadata you can add to a document. The data is located between a pair of `---` lines at the start of a document. With this parser the format can be any format you would like.
```
---
The front matter
---

The content
```

A more practical and complicated example using YAML front matter with Liquid to generate some HTMLc ould look like below.
```
---
layout: post
title: Blogging Like a Hacker
---

<h1>{{ title }}</h1>
<p>This is the content.</p>
```

One of the most common, but not the only, uses for front matter is to use this with [Liquid](https://shopify.github.io/liquid/) ([crystal implementation](https://github.com/wmoxam/liquid-crystal)), or a similar templating language.


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
	# Parse the front matter as YAML, JSON or something else?

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


## Contributing

1. Fork it ( https://github.com/chris-huxtable/front_matter.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request


## Contributors

- [Chris Huxtable](https://github.com/chris-huxtable) - creator, maintainer
