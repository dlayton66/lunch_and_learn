class BadPasswordError < StandardError
  def message
    "Wrong password"
  end
end