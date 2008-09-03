# Allow boolean attributes to be null-ed by ''.
class ActiveRecord::ConnectionAdapters::Column
  def self.value_to_boolean(value)
    if value == true || value == false || value == nil
      value
    else
      case value.to_s.downcase
      when 'true', 't', '1'
        true
      when 'false', 'f', '0'
        false
      when ''
        nil
      else
        false
      end
    end
  end
end
