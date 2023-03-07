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
      if defined?(exception.record)
        exception.record.errors.full_messages.map do |message|
          { detail: message }
        end
      else
        [{detail: exception.message}]
      end
    end
end