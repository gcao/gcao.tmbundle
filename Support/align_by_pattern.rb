module AlignByPattern
  def align_by_pattern lines, pattern
    pattern = Regexp.new pattern
    
    best_column = 0
    for line in lines
      if line =~ pattern then
        m = pattern.match(line)
        best_column = m.begin(0) if m.begin(0) > best_column
      end
    end
    
    lines.map do |line|
      if line =~ pattern then
        before = $`
        after = line[before.length..-1]
        [before.ljust(best_column), after].join
      else
        line
      end
    end
  end
end
