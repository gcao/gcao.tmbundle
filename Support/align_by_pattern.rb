module AlignByPattern
  def align_by_pattern lines, first_pattern, *more_patterns
    lines = align_by_first_pattern lines, first_pattern
    
    pattern_before = first_pattern

    0.upto(more_patterns.length - 1) do |i|
      pattern        = more_patterns.pop
      lines          = align_by_subsequent_pattern lines, pattern_before, pattern
      pattern_before = pattern_before + ".*" + pattern
    end
    
    lines
  end
  
  private
  
  def align_by_first_pattern lines, pattern
    pattern = Regexp.new pattern
    
    best_column = 0
    for line in lines
      if line =~ pattern then
        m           = pattern.match(line)
        best_column = m.begin(0) if m.begin(0) > best_column
      end
    end
    
    lines.map do |line|
      if line =~ pattern then
        before = $`
        after  = line[before.length..-1]
        [before.ljust(best_column), after].join
      else
        line
      end
    end
  end
  
  def align_by_subsequent_pattern lines, pattern_before, pattern
    pattern = Regexp.new pattern_before + ".*(" + pattern + ")"
    
    best_column = 0
    for line in lines
      if line =~ pattern then
        m           = pattern.match(line)
        best_column = m.begin(1) if m.begin(1) > best_column
      end
    end
    
    lines.map do |line|
      if line =~ pattern then
        before = line[0..$~.begin(1) - 1]
        after  = line[before.length..-1]
        [before.ljust(best_column), after].join
      else
        line
      end
    end
  end
end
