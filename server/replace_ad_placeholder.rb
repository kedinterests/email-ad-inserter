# frozen_string_literal: true

# This runs after Discourse initializes
after_initialize do
  # Patch Email::Renderer to replace %{ad_placeholder} with the theme setting value
  Email::Renderer.class_eval do
	alias_method :original_replace_variables, :replace_variables

	def replace_variables(text, opts)
	  result = original_replace_variables(text, opts)
	  ad_content = ThemeModifier.get_setting(:ad_placeholder_content).to_s
	  result.gsub('%{ad_placeholder}', ad_content)
	end
  end
end