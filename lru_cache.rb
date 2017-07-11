# Doubly linked list implementation of LRU
# uses Hash#delete to remove the oldest item when cache is full

class Node
  attr_accessor :next, :prev, :key, :value
  def initialize next_node, prev_node, key, value
    @key = key
    @value = value
    @next = next_node
    @prev = prev_node
  end
end

class LRU
  attr_accessor :head, :tail, :size, :capacity
  def initialize capacity
    @capacity = capacity
    @store = {}
    @head = nil
    @tail = nil
    @size = 0
  end
  
  def set key, value
    if @size >= @capacity
      @store.delete(@head.key)
      @head = @head.next
    else
      @size += 1
    end
    
    new_node = Node.new nil, @tail, key, value
    if @tail
      @tail.next = new_node
    else
      @head = new_node
    end
    @tail = new_node
    @store[key] = new_node
  end
  
  def get key
    node = @store[key]
    return nil unless node
    return node.value unless node.next
    if node.prev
      node.prev.next = node.next
    else
      @head = node.next
      @head.prev = nil
    end
    @tail.next = node
    node.next = nil
    node.prev = @tail
    @tail = node
    node.value
  end
end
