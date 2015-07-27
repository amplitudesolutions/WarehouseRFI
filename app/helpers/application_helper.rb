module ApplicationHelper
	def active_if(options)
      if params.merge(options) == params
        'active'
      end
  end
end