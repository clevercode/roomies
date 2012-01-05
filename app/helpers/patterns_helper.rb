module PatternsHelper
  def render_pattern(selector, template_name = nil, options = {}, &block)
    content_tag :div, :class => 'argyle_pattern' do
      content_tag :code, selector
      pattern = if block_given?
                  capture(&block)
                elsif template_name
                  options[:file] = template_name
                  render(options)
                else
                  'pattern not given'
                end
      out = ''
      out << content_tag(:code, selector, :class => 'argyle_selector')
      out << pattern
      raw(out)
    end
  end
  def unique_pattern_id
    @pattern_counter ||= 0
    @pattern_counter += 1
    "pattern_fake_#{@pattern_counter}"
  end
end
