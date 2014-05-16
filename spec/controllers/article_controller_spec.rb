require 'spec_helper'

describe ArticleController do

  describe "# GitHub Flavored Markdown" do
    it "return to :html" do
      post 'gfm', {:markdown => "This is *bongos*, indeed."}
      expect(response.body).to match '<p>This is <em>bongos</em>, indeed.</p>'
    end
    describe "Header" do
      it "Underlined Header" do
        # Underlined Header
        # Note that it supports only H1 and H2.
        post 'gfm', {:markdown => "H1\n=============\nH2\n-------------"}
        expect(response.body.gsub("\n", '')).to match '<h1>H1</h1><h2>H2</h2>'
      end
      context "Hashed Header" do
        it "# h1" do
          post 'gfm', {:markdown => "# h1"}
          expect(response.body.gsub("\n", '')).to match '<h1>h1</h1>'
        end
        it "# h1 #" do
          # Note that the closing hash may not necessarily be the same amount as the starting hash, for example
          # # h1 with different closing hash ##
          # Similar, you could use the hash indent for other headers:
          post 'gfm', {:markdown => "# h1 #"}
          expect(response.body.gsub("\n", '')).to match '<h1>h1</h1>'
        end
        it "# h1 ##" do
          post 'gfm', {:markdown => "# h1 ##"}
          expect(response.body.gsub("\n", '')).to match '<h1>h1</h1>'
        end
        it "## h2" do
          post 'gfm', {:markdown => "## h2"}
          expect(response.body.gsub("\n", '')).to match '<h2>h2</h2>'
        end
        it "### h3" do
          post 'gfm', {:markdown => "### h3"}
          expect(response.body.gsub("\n", '')).to match '<h3>h3</h3>'
        end
        it "#### h4" do
          post 'gfm', {:markdown => "#### h4"}
          expect(response.body.gsub("\n", '')).to match '<h4>h4</h4>'
        end
        it "##### h5" do
          post 'gfm', {:markdown => "##### h5"}
          expect(response.body.gsub("\n", '')).to match '<h5>h5</h5>'
        end
        it "###### h6" do
          post 'gfm', {:markdown => "###### h6"}
          expect(response.body.gsub("\n", '')).to match '<h6>h6</h6>'
        end
      end
    end
    describe "Paragraph" do
      # This is a paragraph. Same as wrapping text in `<p>...</p>`.
      # Note that there should be at least one blank line between paragraphs.
      it "Single line" do
        post 'gfm', {:markdown => "paragraph"}
        expect(response.body.gsub("\n", '')).to match '<p>paragraph</p>'
      end
      it "Multi line" do
        post 'gfm', {:markdown => "first\n\nsecond\nthird"}
        expect(response.body.gsub("\n", '')).to match '<p>first</p><p>second<br>third</p>'
      end
    end
    describe "Blockquote" do
      it "Single line" do
        post 'gfm', {:markdown => "> This a blockquote."}
        expect(response.body.gsub("\n", '')).to match '<blockquote><p>This a blockquote.</p></blockquote>'
      end
      it "Nested" do
        post 'gfm', {:markdown => "> first\n>> second\n>>> third"}
        expect(response.body.gsub("\n", '')).to match '<blockquote><p>first</p><blockquote><p>second</p><blockquote><p>third</p></blockquote></blockquote></blockquote>'
      end
    end
    describe "List" do
      context "Unordered List" do
        it "* list" do
          post 'gfm', {:markdown => "* list\n* list"}
          expect(response.body.gsub("\n", '')).to match '<ul><li>list</li><li>list</li></ul>'
        end
        it "- list" do
          post 'gfm', {:markdown => "- list\n- list"}
          expect(response.body.gsub("\n", '')).to match '<ul><li>list</li><li>list</li></ul>'
        end
        it "+ list" do
          post 'gfm', {:markdown => "+ list\n+ list"}
          expect(response.body.gsub("\n", '')).to match '<ul><li>list</li><li>list</li></ul>'
        end
      end
      context "Ordered List" do
        it "order list" do
          post 'gfm', {:markdown => "1. list\n2. list"}
          expect(response.body.gsub("\n", '')).to match '<ol><li>list</li><li>list</li></ol>'
        end
        it "random list" do
          # Please note that the following sample is not well supported by Github
          post 'gfm', {:markdown => "3. list\n9. list\n18. list"}
          expect(response.body.gsub("\n", '')).to match '<ol><li>list</li><li>list</li><li>list</li></ol>'
        end
      end
      context "Sub-List" do
      end
    end
    describe "Emphasis" do
      # Asterisks * and underscores _ can be used to produce emphasis elements.
      it "Italic" do
        post 'gfm', {:markdown => "*Italic*"}
        expect(response.body.gsub("\n", '')).to match '<em>Italic</em>'
      end
      it "Bold" do
        post 'gfm', {:markdown => "**Bold**"}
        expect(response.body.gsub("\n", '')).to match '<strong>Bold</strong>'
      end
    end
    describe "Code" do
      # To escape `, see the section "Backslash Escape" . Or just use HTML entity `
      it "Code Span" do
        post 'gfm', {:markdown => "`code`"}
        expect(response.body.gsub("\n", '')).to match '<p><code>code</code></p>'
      end
      context "Code Block" do
        it "```" do
          post 'gfm', {:markdown => "```\nprecode\n```"}
          expect(response.body.gsub("\n", '')).to match '<pre><code>precode</code></pre>'
        end
        it "indent 4 spaces" do
          post 'gfm', {:markdown => "    precode"}
          expect(response.body.gsub("\n", '')).to match '<pre><code>precode</code></pre>'
        end
        it "Syntax highlighting" do
          post 'gfm', {:markdown => "```ruby\nprecode\n```"}
          expect(response.body.gsub("\n", '')).to match '<pre lang="ruby"><code>precode</code></pre>'
        end
      end
      context "Escape" do
        it "backslash" do
          post 'gfm', {:markdown => "\\\ value"}
          expect(response.body.gsub("\n", '')).to eq '<p>\ value</p>'
        end
        it "backtick" do
          post 'gfm', {:markdown => "\\` value"}
          expect(response.body.gsub("\n", '')).to eq '<p>` value</p>'
        end
        it "asterisk" do
          post 'gfm', {:markdown => "\\* value"}
          expect(response.body.gsub("\n", '')).to eq '<p>* value</p>'
        end
        it "underscore" do
          post 'gfm', {:markdown => "\\_ value"}
          expect(response.body.gsub("\n", '')).to eq '<p>_ value</p>'
        end
        it "curly braces" do
          post 'gfm', {:markdown => "\\{\\} value"}
          expect(response.body.gsub("\n", '')).to eq '<p>{} value</p>'
        end
        it "square brackets" do
          post 'gfm', {:markdown => "\\[\\] value"}
          expect(response.body.gsub("\n", '')).to eq '<p>[] value</p>'
        end
        it "parentheses" do
          post 'gfm', {:markdown => "\\(\\) value"}
          expect(response.body.gsub("\n", '')).to eq '<p>() value</p>'
        end
        it "hash mark" do
          post 'gfm', {:markdown => "\\# value"}
          expect(response.body.gsub("\n", '')).to eq '<p># value</p>'
        end
        it "plus sign" do
          post 'gfm', {:markdown => "\\+ value"}
          expect(response.body.gsub("\n", '')).to eq '<p>+ value</p>'
        end
        it "minus sign" do
          post 'gfm', {:markdown => "\\- value"}
          expect(response.body.gsub("\n", '')).to eq '<p>- value</p>'
        end
        it "dot" do
          post 'gfm', {:markdown => "\\. value"}
          expect(response.body.gsub("\n", '')).to eq '<p>. value</p>'
        end
        it "exclamation mark" do
          post 'gfm', {:markdown => "\! value"}
          expect(response.body.gsub("\n", '')).to eq '<p>! value</p>'
        end
      end
    end
    describe "Link" do
      context "Inline Link" do
        it "External link with title" do
          post 'gfm', {:markdown => '[ Github ](https://github.com "Search Engine")'}
          expect(response.body.gsub("\n", '')).to match '<p><a href=\"https://github.com\" title=\"Search Engine\"> Github </a></p>'
        end
        it "External link without title" do
          post 'gfm', {:markdown => '[ Github ](https://github.com)'}
          expect(response.body.gsub("\n", '')).to match '<p><a href=\"https://github.com\"> Github </a></p>'
        end
        it "Local link" do
          post 'gfm', {:markdown => '[ Local ](/local)'}
          expect(response.body.gsub("\n", '')).to match '<p><a href=\"/local\"> Local </a></p>'
        end
      end
      it "URL Autolinking" do
        post 'gfm', {:markdown => "https://github.com"}
        expect(response.body.gsub("\n", '')).to match '<p><a href=\"https://github.com\">https://github.com</a></p>'
      end
      it "Disabled Reference Link" do
        # Disabled
        post 'gfm', {:markdown => "[ Disabled ][]"}
        expect(response.body.gsub("\n", '')).to_not match '.*<a.*'
      end
    end
    describe "Image" do
      it "Inline Image" do
        post 'gfm', {:markdown => "![ Logo ](http://www.google.com/images/logo.png)"}
        expect(response.body.gsub("\n", '')).to match '<p><img src=\"http://www.google.com/images/logo.png\" alt=\" Logo \"></p>'
      end

      it "Disabled Reference Image" do
        # Disabled
        post 'gfm', {:markdown => "![ Disabled ][]"}
        expect(response.body.gsub("\n", '')).to match '<p>\!\[ Disabled \]\[\]</p>'
      end
    end
    describe "Table" do
      # Please note that the header underline separator has to be 3 characters wide.
      # Also note that block elements can't be used in the table
      it "opening and closing pipeline" do
        post 'gfm', {:markdown => "| Header | Header | Header | Header |\n| ------ | :----- | :----: | -----: |\n| Auto   | Left   | Center | Right  |\n"}
        expect(response.body.gsub("\n", '')).to match '<table><thead><tr><th>Header</th><th align="left">Header</th><th align="center">Header</th><th align="right">Header</th></tr></thead><tbody><tr><td>Auto</td><td align="left">Left</td><td align="center">Center</td><td align="right">Right</td></tr></tbody></table>'
      end
      it "remove opening and closing pipeline" do
        post 'gfm', {:markdown => "Header | Header | Header | Header\n--- | :-- | :-: | --:\nAuto | Left | Center | Right"}
        expect(response.body.gsub("\n", '')).to match '<table><thead><tr><th>Header</th><th align="left">Header</th><th align="center">Header</th><th align="right">Header</th></tr></thead><tbody><tr><td>Auto</td><td align="left">Left</td><td align="center">Center</td><td align="right">Right</td></tr></tbody></table>'
      end
    end
    it "Disabled Task List" do
      # Disabled
      post 'gfm', {:markdown => "- [ ] disabled"}
      expect(response.body.gsub("\n", '')).to_not match '.*input.*</p>'
    end
  end
end
