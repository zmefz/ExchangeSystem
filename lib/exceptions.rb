module Errors
  class TransactionCreatingError < StandardError
    attr_reader :errors
    def initialize(errors)
      @errors = errors
      super('')
    end
  end
end
