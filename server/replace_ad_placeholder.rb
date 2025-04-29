# frozen_string_literal: true

after_initialize do
  Email::Renderer.class_eval do
    alias_method :original_replace_variables, :replace_variables

    def replace_variables(text, opts)
      result = original_replace_variables(text, opts)

      # 🟢 Hardcoded Ad Content
      ad_content = <<~HTML
        <hr>
        <p style="font-size: 14px; color: #555; text-align: center;">
          🚀 Check out our latest guide:
          <a href="https://yourwebsite.com/awesome-guide" style="color: #0077cc; text-decoration: underline;">
            5 Ways to Boost Your Forum Engagement
          </a>
        </p>
      HTML

      # Replace the magic tag
      result.gsub('%{ad_placeholder}', ad_content)
    end
  end
end
