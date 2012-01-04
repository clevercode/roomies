module PatternsHelper
  def render_pattern(selector,template=nil,&block)
    content_tag :div, :class => 'argyle_pattern' do
      content_tag :code, selector
      pattern = if block_given?
        capture(&block)
      else
        render(template) if template 
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
