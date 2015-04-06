class Markup
  def self.format(text)
    result = RDiscount.new(text, :smart, :filter_html, :autolink, :safelink).to_html

    result.html_safe
  end
end
