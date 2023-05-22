# class PolyTreeNode
  
#     attr_accessor :parent, :children, :pos
  
#     def initialize(pos)
#         @parent = []
#         @children = []
#         @pos = pos
#     end 

#     def parent= (node)
#         if self.parent != nil && self.parent != node
#             self.parent.children.delete(self)  
#         end 
#         @parent = node
#         if node != nil && !parent.children.include?(self)

#             parent.children << self
#         else 
#             return nil 
#         end 
#     end 

#     def add_child(child_node)
#         child_node.parent = self
#         self.children << child_node if !self.children.include?(child_node)
#     end 

#     def remove_child(child_node)
#         child_node.parent = nil
#         if self.children.include?(child_node)
#             self.children.delete(child_node) 
#         else
#             raise "not a child"
#         end 
#     end 

#     def inspect
#         "#PolyTreeNode#{self.object_id}  @parent=#{@parent}   @children = #{@children}"
#     end

#     def dfs(target_value)
#         return self if self.pos == target_value
#         self.children.each do |child|
#            result = child.dfs(target_value)
#            if result != nil
#             return result
#            end
#         end 
#         return nil

#     end 

    def bfs(target_value)
        queue = []
        queue << self

        until queue.empty?
            current_child = queue.shift

            if current_child.pos == target_value
                return current_child
            else
                queue += current_child.children
            end 
        end 
        return nil

    end 

# end

module Searchable
    # This is written as a mixin to make it easier to later write another
    # TreeNode class (e.g., BinaryTreeNode). All you need is `#children` and
    # `#value` for `Searchable` to work.
  
    def dfs(target = nil, &prc)
      raise "Need a proc or target" if [target, prc].none?
      prc ||= Proc.new { |node| node.value == target }
  
      return self if prc.call(self)
  
      children.each do |child|
        result = child.dfs(&prc)
        return result unless result.nil?
      end
  
      nil
    end
  
    # def bfs(target = nil, &prc)
    #   raise "Need a proc or target" if [target, prc].none?
    #   prc ||= Proc.new { |node| node.value == target }
  
    #   nodes = [self]
    #   until nodes.empty?
    #     node = nodes.shift
  
    #     return node if prc.call(node)
    #     nodes.concat(node.children)
    #   end
  
    #   nil
    # end
  
    #alternate solution to bfs
  #   def bfs(target)
  #     queue = [self]
  
  #     queue.each do |child|
  #       return child if child.value == target
  
  #       queue.concat(child.children)
  #     end
  #     nil
  #   end
  
  #   def count
  #     1 + children.map(&:count).inject(:+)
  #   end
  end
  
  class PolyTreeNode
    include Searchable
  
    attr_accessor :value
    attr_reader :parent
  
    def initialize(value = nil)
      @value, @parent, @children = value, nil, []
    end
  
    def children
      # Dup to avoid someone inadvertently trying to modify our
      # children directly through the children array. Note that
      # `parent=` works hard to make sure children/parent always match
      # up. Don't trust our users to do this.
      @children.dup
    end
  
    def parent=(parent)
      return if self.parent == parent
  
      # First, detach from current parent.
      if self.parent
        self.parent._children.delete(self)
      end
  
      # No new parent to add this to.
      @parent = parent
      self.parent._children << self unless self.parent.nil?
  
      self
    end
  
    def add_child(child)
      # Just reset the child's parent to us!
      child.parent = self
    end
  
    def remove_child(child)
      # Thanks for doing all the work, `parent=`!
      if child && !self.children.include?(child)
        raise "Tried to remove node that isn't a child"
      end
  
      child.parent = nil
    end
  
    protected
    
    # Protected method to give a node direct access to another node's
    # children.
    def _children
      @children
    end
  end
