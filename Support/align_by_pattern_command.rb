#!/usr/bin/env ruby

require ENV['TM_SUPPORT_PATH'] + '/lib/textmate'
require ENV['TM_SUPPORT_PATH'] + '/lib/ui'

input   = STDIN.readlines
pattern = Regexp.new TextMate::UI.request_string(:title => 'Align by Pattern', :prompt => 'Please enter a pattern to align text:')

require File.expand_path(File.dirname(__FILE__) + '/align_by_pattern')
include AlignByPattern

result  = align_by_pattern input, pattern

STDOUT.print result.join
