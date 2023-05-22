class PolyTreeNode
  
    attr_accessor :parent, :children, :pos
  
    def initialize(pos)
        @parent = []
        @children = []
        @pos = pos
    end 

    def parent= (node)
        if self.parent != nil && self.parent != node
            self.parent.children.delete(self)  
        end 
        @parent = node
        if node != nil && !parent.children.include?(self)

            parent.children << self
        else 
            return nil 
        end 
    end 

    def add_child(child_node)
        child_node.parent = self
        self.children << child_node if !self.children.include?(child_node)
    end 

    def remove_child(child_node)
        child_node.parent = nil
        if self.children.include?(child_node)
            self.children.delete(child_node) 
        else
            raise "not a child"
        end 
    end 

    def inspect
        "#PolyTreeNode#{self.object_id}  @parent=#{@parent}   @children = #{@children}"
    end

    def dfs(target_value)
        return self if self.pos == target_value
        self.children.each do |child|
           result = child.dfs(target_value)
           if result != nil
            return result
           end
        end 
        return nil

    end 

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

end

