class RulesController < ApplicationController
	def index
		@rules = Rule.all
	end

	def new
		@rule = Rule.new
		
		# If description passed, populate it. If not, stays blank.
		@rule.search_text = params[:desc]
		@types = Type.all
	end

	def create
		@rule = Rule.create(rule_params)
		@rules = Rule.all
	end

	def edit
		@rule = Rule.find(params[:id])
		@types = Type.all
	end

	def update
		@rule = Rule.find(params[:id])
		@rule.update_attributes(rule_params)
		@rules = Rule.all
	end

	private
		def rule_params
			params.require(:rule).permit(:display_text, :search_text, :type_id)
		end
end