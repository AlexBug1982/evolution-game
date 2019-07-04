module BooleanHelper

  def parse_to_solid_boolean(value)
    case value
    when true, 'true', 1, '1', 't' then true
    when false, 'false', nil, '', 0, '0', 'f' then false
    else
      raise ArgumentError, "invalid value for Boolean(): \"#{value.inspect}\""
    end
  end


end
