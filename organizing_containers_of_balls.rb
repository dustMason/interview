def swap containers
  
  container_sums = containers.map { |c| c.reduce &:+ }
  ball_type_sums = containers.transpose.map { |c| c.reduce &:+ }
  
  if container_sums.sort == ball_type_sums.sort
    return "Possible"
  else
    return "Impossible"
  end
  
end
