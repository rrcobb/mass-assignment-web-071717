class Person
  # Can take arbitrary keyword arguments
  def initialize(attributes)
    attributes.each { |k, v| self.send("#{k}=", v) }
  end

  # Uses instance_variable_set and instance_variable_get
  # To set arbitrary instance vars
  # and get them if they are defined
  def method_missing(method, *arguments, &block)
    # only instance_variable_set from the initialize method
    if method.to_s.end_with?('=') && caller[0].include?('initialize')
      self.instance_variable_set('@' + method.to_s[0..-2], *arguments)
    elsif defined?("@#{method}".to_sym)
      self.instance_variable_get("@#{method}")
    else
      super
    end
  end
end
