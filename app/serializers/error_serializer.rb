class ErrorSerializer
  def initialize(exception = nil)
    @exception = exception
  end

  def serialize
    {
      errors: get_errors_array(@exception)
    }
  end

  private

    def get_errors_array(exception)
      exception.record.errors.full_messages.map do |message|
        { detail: message }
      end
    end
end