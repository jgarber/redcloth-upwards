require File.dirname(__FILE__) + "/spec_helper"

describe RedCloth do
  
  it "should parse something simple and return HTML" do
    RedCloth.new("Test.").to_html.should == "<p>Test.</p>"
  end
  
end