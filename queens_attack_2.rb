n, k = gets.strip.split(' ').map &:to_i
queen = gets.strip.split(' ').map &:to_i
obstacles = []
for a0 in (0..k-1)
  obstacles << gets.strip.split(' ').map(&:to_i)
end

nearest_s = nearest_w = 0
nearest_e = nearest_n = n+1

distance_ne = [n - queen[0], n - queen[1]].min + 1
distance_nw = [n - queen[0], queen[1]-1].min + 1
distance_sw = [queen[0]-1, queen[1]-1].min + 1
distance_se = [queen[0]-1, n - queen[1]].min + 1

obstacles.each do |r, c|
  if r == queen[0] && c > queen[1] && c < nearest_e
    nearest_e = c
  elsif r == queen[0] && c < queen[1] && c > nearest_w
    nearest_w = c
  elsif c == queen[1] && r > queen[0] && r < nearest_n
    nearest_n = r
  elsif c == queen[1] && r < queen[0] && r > nearest_s
    nearest_s = r
  end
  
  # diagonals
  hdist = (queen[0] - r).abs
  vdist = (queen[1] - c).abs
  
  if hdist == vdist
    if r > queen[0]
      if c > queen[1]
        distance_ne = [hdist, distance_ne].min
      else
        distance_nw = [hdist, distance_nw].min
      end
    else
      if c > queen[1]
        distance_se = [hdist, distance_se].min
      else
        distance_sw = [hdist, distance_sw].min
      end
    end
  end
  
end

total = 0

[nearest_e, nearest_w].each do |n|
  total += (queen[1] - n).abs - 1
end
[nearest_n, nearest_s].each do |n|
  total += (queen[0] - n).abs - 1
end

[distance_sw, distance_se, distance_nw, distance_ne].each do |d|
  total += d - 1
end

puts total
