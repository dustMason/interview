# Your company delivers breakfast via autonomous quadcopter drones. And
# something mysterious has happened. Each breakfast delivery is assigned a
# unique ID, a positive integer. When one of the company's 100 drones takes off
# with a delivery, the delivery's ID is added to an array,
# delivery_id_confirmations. When the drone comes back and lands, the ID is
# again added to the same array.

# After breakfast this morning there were only 99 drones on the tarmac. One of
# the drones never made it back from a delivery. We suspect a secret agent from
# Amazon placed an order and stole one of our patented drones. To track them
# down, we need to find their delivery ID.
 
# Given the array of IDs, which contains many duplicate integers and one unique
# integer, find the unique integer.

# The IDs are not guaranteed to be sorted or sequential. Orders aren't always
# fulfilled in the order they were received, and some deliveries get cancelled
# before takeoff.

class RoleCaller
  def self.check ids=[]
    ids.reduce &:^
  end
end
  
base_case = ((0..99).to_a + (0..99).to_a).shuffle
base_target = base_case[5]
base_case.delete_at 5

{
  [0, 0, 1, 2, 2, 3, 3] => 1,
  base_case => base_target
}.each do |input, output|
  result = RoleCaller.check input
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
