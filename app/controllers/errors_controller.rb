class ErrorsController < ApplicationController
  def not_found
    head 404
  end

  def unacceptable
    head 422
  end

  def internal_error
    head 500
  end
end
