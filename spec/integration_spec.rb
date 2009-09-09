require File.dirname(__FILE__) + "/spec_helper"

describe RedCloth do
  
  def text(input)
    @input = input
  end
  
  def html(expected_output)
    RedCloth.new(@input).to_html.should == expected_output.chomp
  end
  
  it "should parse something simple and return HTML" do
    text "Test."
    html "<p>Test.</p>"
  end
  
  it "should parse successive paragraphs" do
    text "A single paragraph.\n\nFollowed by another."
    html "<p>A single paragraph.</p>\n<p>Followed by another.</p>"
  end
  
  it "should parse paragraphs with extra whitespace on separating line" do
    text "This is line one\n \nThis is line two"
    html "<p>This is line one</p>\n<p>This is line two</p>"
  end

  it "should parse em inside of strong" do
    text "*Pay attention to _this_*."
    html "<p><strong>Pay attention to <em>this</em></strong>.</p>"
  end
  
  it "should parse link inside bold" do
    text %{I use *"Google":http://www.google.com*, not Bing}
    html %{<p>I use <strong><a href="http://www.google.com">Google</a></strong>, not Bing</p>}
  end
  
  it "should leave certain punctuation off the end of links" do
    text %Q{Read about "Textile":http://en.wikipedia.org/wiki/Textile_(markup_language) or "try it out":http://redcloth.org/try-redcloth/!}
    html "<p>Read about <a href=\"http://en.wikipedia.org/wiki/Textile_(markup_language)\">Textile</a> or <a href=\"http://redcloth.org/try-redcloth/\">try it out</a>!</p>"
  end
  
  it "should allow links to end parentheticals" do
    text %{The first version of RedCloth released on RubyForge was "2.0.3":http://rubyforge.org/frs/shownotes.php?release_id=382 (same on "the ruby application archive":http://raa.ruby-lang.org/project/redcloth/2.0.3).}
    html %{<p>The first version of RedCloth released on RubyForge was <a href="http://rubyforge.org/frs/shownotes.php?release_id=382">2.0.3</a> (same on <a href="http://raa.ruby-lang.org/project/redcloth/2.0.3">the ruby application archive</a>).</p>}
    
  end
  
  it "should allow quotations in a link" do
    text %Q{"You can see it on "The Rachel Maddow Show"":http://rachel.msnbc.com}
    html "<p><a href=\"http://rachel.msnbc.com\">You can see it on &#8220;The Rachel Maddow Show&#8221;</a></p>"
  end
  
  it "should parse links in quotes" do
    text %Q{"Check out "my blog":/blog," she said.}
    html "<p>&#8220;Check out <a href=\"/blog\">my blog</a>,&#8221; she said.</p>"
  end
  
  it "should parse really complex numbered lists" do
    text <<-EOD
(listclass#listid)#(myclass#myid) one
#(twoclass) two
(nestedtwo)##(#two-one) two.one
##(twoclass) two.two

#_ three
EOD
    html <<-EOD
<ol class="listclass" id="listid">
	<li class="myclass" id="myid">one</li>
	<li class="twoclass">two
	<ol>
		<li id="two-one">two.one</li>
		<li class="twoclass">two.two</li>
	</ol></li>
</ol>
<ol start="3">
	<li>three</li>
</ol>
EOD
  end
  
  it "should parse an explicit paragraph with padding" do
    text "p((myclass#myid). This is my paragraph"
    html %{<p style="padding-left:1em;" class="myclass" id="myid">This is my paragraph</p>}
  end
  
  it "should parse a list with padding" do
    text "(# hello"
    html <<-EOD
<ol style="padding-left:1em;">
	<li>hello</li>
</ol>
EOD
  end
  
end