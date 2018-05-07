# Copyright (c) 2018 Christian Huxtable <chris@huxtable.ca>.
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

require "./spec_helper"

private def it_parses(string : String, frontmatter, content, file = __FILE__, line = __LINE__)
	it "parses #{string}", file, line do
		FrontMatter.parse(string) { |f_frontmatter, f_content|
			f_frontmatter.should eq(frontmatter)
			f_content.should eq(content)
		}
	end
end

private def it_raises_on_parse(string : String, file = __FILE__, line = __LINE__)
	it "raises on parse #{string}", file, line do
		expect_raises FrontMatter::MalformedError do
			FrontMatter.parse(string) { |f_frontmatter, f_content|
				f_frontmatter.should be_nil
				f_content.should be_nil
			}
		end
	end
end

describe FrontMatter do

	describe "parses files" do

		it "while trimming newlines" do
			FrontMatter.open("./spec/sample.txt") { |frontmatter, content|
				frontmatter.should eq("frontmatter")
				content.gets_to_end.should eq("content\n")
			}
		end

		it "without trimming newlines" do
			FrontMatter.open("./spec/sample.txt", skip_newlines: false) { |frontmatter, content|
				frontmatter.should eq("frontmatter")
				content.gets_to_end.should eq("\ncontent\n")
			}
		end

	end

	it "parses basics" do

		it_parses "---\nfrontmatter\n---\ncontent\n", "frontmatter", "content\n"
		it_parses "---\nfrontmatter\n---\n\ncontent\n", "frontmatter", "content\n"
		it_parses "---\n\n---\ncontent\n", "", "content\n"
		it_parses "---\nfrontmatter\n---\n\n", "frontmatter", ""
		it_parses "---\n\n---\n\n", "", ""

		it_parses "---\nThis\nis\na\nmulti-line\ntest\n---\n\n", "This\nis\na\nmulti-line\ntest", ""

		it_raises_on_parse "frontmatter content"
		it_raises_on_parse "---\nfrontmatter content"
		it_raises_on_parse "---frontmatter---\ncontent"
		it_raises_on_parse "---\nfrontmatter---content"

	end

end
