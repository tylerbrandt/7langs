class Tree
	attr_accessor :children, :node_name
	
	def initialize(initial={})
		@children = []
		@node_name = nil
		if not initial.empty?
			# should be only one key
			@node_name = initial.keys[0]
			initial[@node_name].each do |k,v| 
				child_tree = {k=>v}
				@children.push Tree.new child_tree
			end
		end
	end
	
	def visit_all(&block)
		visit &block
		children.each {|c| c.visit_all &block}
	end
	
	def visit(&block) 
		block.call self
	end
end

initial = {'grandpa' => { 'dad' => {'child 1' => {'grandchild' => {}}, 'child 2' => {} }, 'uncle' => {'child 3' => {}, 'child 4' => {} } } }
t = Tree.new initial
t.visit_all {|c| puts c.node_name}