require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'align_by_pattern'

describe AlignByPattern do
  include AlignByPattern
  
  it "should align text by pattern" do
    input = <<-TEXT.lines
      a = 1
      bc = 2
    TEXT
    align_by_pattern(input, '=').should == <<-TEXT.lines.to_a
      a  = 1
      bc = 2
    TEXT
  end
end