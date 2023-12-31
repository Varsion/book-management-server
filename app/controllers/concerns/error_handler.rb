module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from(ActiveRecord::RecordNotFound) { |err| handle_404(err: err) }
    rescue_from(ActiveRecord::RecordInvalid) { |err| handle_record_invalid(err: err) }
  end

  def handel_error(status:, err: nil, message:, fields: nil)
    if err.is_a?(Exception)
      message ||= err.message
      fields ||= err.class
    end

    render json: {
      message: message || "System Error",
      fields: fields,
    }, status: status
  end

  def handle_404(err: nil, message: "Recourse Not Found", fields: nil)
    handel_error(status: 404, err: err, message: message, fields: fields)
  end

  def handle_record_invalid(err:)
    handel_error(status: 400, err: err, message: err.message || "Bad Request", fields: err.class)
  end

  def handle_active_record_validation_errors(errors: nil, status: 422)
    result = errors.map do |err|
      {
        field: err.attribute,
        message: err.type,
      }
    end
    render json: result, status: status
  end
end
