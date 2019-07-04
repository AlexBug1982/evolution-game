module ActiveAdmin::ViewsHelper

  def remove_unicode(string)
    string.encode("iso-8859-1", undef: :replace, replace: "") rescue string
  end

  def show_data_inline(record:, attribute:, nested_attribute: nil, new_line: true)
    value = record.try(attribute)
    value = value.try(nested_attribute) if nested_attribute.present?
    if value.present?
      main_content = inline_data_content(value, attribute, nested_attribute)
      main_content.concat(new_line ? '<br />'.html_safe : ' | ')
    end
  end

  def format_without_time(date)
    date&.strftime('%B %d, %Y')
  end

  def format_comment(comment)
    "#{comment.created_at.strftime("%Y-%m-%d %H:%M")}: #{comment.body}"
  end

end
