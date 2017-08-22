# https://www.hackerrank.com/challenges/the-grid-search

def grid_search needle, haystack
  return false if needle.size < 1
  
  needle_width = needle.first.size
  needle_height = needle.size
  haystack_width = haystack.first.size
  
  haystack.each_with_index do |haystack_row, r|
    haystack_row.each_char.with_index do |haystack_char, c|
      if haystack_char == needle[0][0]
        catch :no_match do
          needle_height.times do |i|
            if haystack[r+i][c..c+needle_width-1] != needle[i]
              throw :no_match
            end
          end
          return 'YES'
        end
      end
    end
  end
  
  return 'NO'
end

{
  [%w{7283455864 6731158619 8988242643 3830589324 2229505813 5633845374
  6473530293 7053106601 0834282956 4607924137}, %w{9505 3845 3530}] => 'YES',
  [%w{400453592126560 114213133098692 474386082879648 522356951189169
      887109450487496 252802633388782 502771484966748 075975207693780
      511799789562806 404007454272504 549043809916080 962410809534811
      445893523733475 768705303214174 650629270887160}, %w{99 99}] => 'NO',
}.each do |(haystack, needle), output|
  result = grid_search(needle, haystack)
  if result == output
    puts "pass"
  else
    puts "fail, expected #{output} got #{result}"
  end
end
