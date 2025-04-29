# frozen_string_literal: true

after_initialize do
  # Extend Email::MessageBuilder to inject our ad_placeholder variable
  Email::MessageBuilder.class_eval do
    alias_method :original_build_custom_variables, :build_custom_variables

    def build_custom_variables
      vars = original_build_custom_variables
      vars[:ad_placeholder] = "" # Dummy value so the validator allows %{ad_placeholder}
      vars
    end
  end

  # Still override replace_variables to actually swap the placeholder with real ad HTML
  Email::Renderer.class_eval do
    alias_method :original_replace_variables, :replace_variables

    def replace_variables(text, opts)
      result = original_replace_variables(text, opts)

      ad_content = <<~HTML
        <hr>
        <p style="font-size: 14px; color: #555; text-align: center;">
          🚀 Check out our latest guide:
          <a href="https://yourwebsite.com/awesome-guide" style="color: #0077cc; text-decoration: underline;">
            5 Ways to Boost Your Forum Engagement
          </a>
        </p>
      HTML

      result.gsub('%{ad_placeholder}', ad_content)
    end
  end
end
