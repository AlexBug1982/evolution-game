# frozen_string_literal: true

module StringHelper
  def strings_are_similar(current, previous)
    return false if current.blank? || previous.blank?
    current_to_lowercase = current.downcase.strip
    previous_to_lowercase = previous.downcase.strip
    ((current_to_lowercase.include? previous_to_lowercase) || (previous_to_lowercase.include? current_to_lowercase))
  end

  def strings_are_similar_case_sensitiv(current, previous)
    return false if current.blank? || previous.blank?
    current_stripped = current.strip
    previous_stripped = previous.strip
    ((current_stripped.include? previous_stripped) || (previous_stripped.include? current_stripped))
  end

  def strings_are_equal_case_sensitiv(current, previous)
    return false if current.blank? || previous.blank?
    ((current.include? previous) || (previous.include? current))
  end

  def strings_are_same(current, previous)
    return false if current.blank? || previous.blank?
    current_to_lowercase = current.downcase.strip
    previous_to_lowercase = previous.downcase.strip
    (current_to_lowercase == previous_to_lowercase)
  end

  require 'amatch'
  include Amatch
  def get_string_distance(string_one, string_two)
    return 0 if string_one.blank? || string_two.blank?
    m = Amatch::PairDistance.new(string_one)
    # m.ignore_case = false
    distance = m.match(string_two)
    distance
  end

  def intersection(source, compared_to)
    common_chars = (source.split('') & compared_to.split(''))
    common_chars.inject(0) do |result, char|
      result + [source.count(char), compared_to.count(char)].min
    end
  end

  def get_combined_equality(matching_chars_count, first_string_length, second_string_length)
    first_string_equality = (matching_chars_count.to_f / first_string_length.to_f * 100).to_i
    second_string_equality = (matching_chars_count.to_f / second_string_length.to_f * 100).to_i
    combined_equality = ((first_string_equality + second_string_equality) / 2).to_i
    combined_equality
  end

  def count_em(string, substring)
    count = if string != '' && substring != ''
              string.scan(substring).size
            else
              0
            end
    count
  end

  def count_em_exact_string(string, substring)
    count = if string != '' && substring != ''
              string.scan(/(?<![\w\d])#{substring}(?![\w\d])/).size
            else
              0
            end
    count
  end

  def islower(char)
    char == char.downcase
  end

  def isupper(char)
    char == char.upcase
  end

  def all_letters(str)
    str !~ /[^a-zA-Z]/i
  end

  def all_digits(str)
    str !~ /[^0-9]/i
  end

  def all_upper(str)
    str == str.upcase
  end

  def all_letters_or_digits(str)
    str !~ /[^a-zA-Z0-9]/i
  end

  def has_letters(str)
    lowercase = ('a'..'z')
    uppercase = ('A'..'Z')
    result = str.each_char.any? { |char| lowercase.cover?(char) || uppercase.cover?(char) }
    result
  end

  def clean_string_from_brackets_block(string)
    cleaned_string = ''
    found_unnesssary_information_prefix = false
    string.each_char do |c|
      if c == '('
        found_unnesssary_information_prefix = true
      elsif c == ')'
        found_unnesssary_information_prefix = false
      elsif !found_unnesssary_information_prefix
        cleaned_string += c
      end
    end
    cleaned_string
  end

  def random_string(length = 5)
    source = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a + ['_', '-', '.']
    key = ''
    length.times { key += source[rand(source.size)].to_s }
    key
  end
end
