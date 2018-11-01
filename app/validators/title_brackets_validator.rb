class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    stack = []
    record.title.chars.each_with_index do |char, index|
      if brackets.key?(char)
        stack << char
        break if empty_brackets(record, char, index)
      elsif brackets.value?(char)
        break if invalid_brackets(record, stack, char)
      end
    end
    brackets_error(record) unless stack.empty?
  end

  private

  def brackets
    { "{" => "}", "[" => "]", "(" => ")" }
  end

  def empty_brackets(record, char, index)
    if brackets[char] == record.title[index + 1]
      record.errors.add(:title, "The title has empty brackets")
    end
  end

  def invalid_brackets(record, stack, char)
    brackets_error(record) if brackets[stack.pop] != char
  end

  def brackets_error(record)
    record.errors.add(:title, "The title has unopened or unclosed brackets")
  end
end
