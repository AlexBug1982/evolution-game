module ActiveRecordErrorParser

  def parse_active_record_error(error)
    error_text = error.gsub(" ", "_")
    error_text = error_text.gsub(/[']/, "_")
    error_text = error_text.gsub(/[()]/, "")
    error_text.downcase!
    error_text.strip!
    error_text
  end
end
