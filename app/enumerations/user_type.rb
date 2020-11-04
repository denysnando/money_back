# frozen_string_literal: true

class UserType < EnumerateIt::Base
  associate_values :admin, :client
end
