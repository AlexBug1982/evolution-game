module MessagesHelper

  # Returns HTML from input text using GitHub-flavored Markdown.
  def markdown_to_html(text)
    return '' if text.blank?
    text = Rinku.auto_link(text, :all, 'target="_blank"')
    Kramdown::Document.new(text, input: 'GFM').to_html
  end

  def message_date_to_date_format(message_date, user_language)
    date_format = I18n.t('time.formats.message', locale: user_language)
    message_date.strftime(date_format)
  end

end
