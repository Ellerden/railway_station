require_relative 'accessors'

# информация о компании-производителе
module Manufacturer
  extend Accessors
  attr_accessor_with_history :company_name
end
