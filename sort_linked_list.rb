def sort_list list
  unless list then return list end
  
  insize = 1
  
  loop do
    _p = list
    list = nil
    tail = nil
    
    nmerges = 0
    
    until _p.nil? do
      nmerges += 1
      q = _p
      psize = 0
      insize.times do
        psize += 1
        q = q.next
        if !q then break end
      end
    
      qsize = insize
      
      while psize > 0 || (qsize > 0 && q) do
        
        if psize == 0
          e = q
          q = q.next
          qsize -= 1
        elsif qsize == 0 || !q
          e = _p
          _p = _p.next
          psize -= 1
        elsif (_p.val - q.val) <= 0
          e = _p
          _p = _p.next
          psize -= 1
        else
          e = q
          q = q.next
          qsize -= 1
        end
        
        if tail
          tail.next = e
        else
          list = e
        end
        tail = e
      end
      
      _p = q
      
    end
    
    tail.next = nil
    
    if nmerges <= 1 then return list end
    
    insize *= 2
  end
end


class ListNode
  attr_accessor :val, :next
  def initialize val
    @val = val
    @next = nil
  end
  def to_a
    _next = @next
    out = [val]
    until _next.nil? do
      out << _next.val
      _next = _next.next
    end
    out
  end
end

{
  [5, 3, 1, 2, 4] => [1, 2, 3, 4, 5],
  [3, 2, 4] => [2, 3, 4],
  [4, 4, 5, 5, 1, 2, 4] => [1, 2, 4, 4, 4, 5, 5],
}.each do |input, output|
  nodes = input.map { |v| ListNode.new(v) }
  nodes.each_with_index { |node, i| node.next = nodes[i+1] }
  result = sort_list(nodes[0]).to_a
  if result == output
    puts "PASS"
  else
    puts "FAIL given #{input}, expected #{output} but got #{result}"
  end
end
