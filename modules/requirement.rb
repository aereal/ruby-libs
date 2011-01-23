module Requirement
	class NotSatisfiedRequirements < StandardError; end

	def included(mod)
		mod.extend(self)
	end

	def use(*args)
		req_mods, req_methods = args.map {|i| i.to_s }.partition {|i| /^[A-Z]/ === i }
		use_modules(req_mods) && use_methods(req_methods)
	end

	def use_modules(*args)
		req_mods = args.map {|i| i.to_s }
		req_mods & ancestors.map {|i| i.to_s } == req_mods || raise NotSatisfiedRequirements
	end

	def use_methods(*args)
		args.all? {|i| method_defined? i.to_s } || raise NotSatisfiedRequirements
	end
end
