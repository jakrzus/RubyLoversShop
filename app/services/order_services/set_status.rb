# frozen_string_literal: true

module OrderServices
  class SetStatus
    def call(resource, event)
      response = resource.aasm.fire! event
      OpenStruct.new(flash: { type: :notice, message: "Succesfully changed #{name(resource)} status!" },
                     payload: response)
    rescue AASM::InvalidTransition, ActiveModel::ValidationError => e
      OpenStruct.new(flash: { type: :alert, message: e.message }, payload: e)
    end

    private

    def name(resource)
      resource.class.to_s.downcase
    end
  end
end
