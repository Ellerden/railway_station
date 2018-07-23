# encoding: UTF-8

require_relative 'wagon'
# # Создание и управление грузовыми вагонами
class CargoWagon < Wagon
  def initialize(manufacturer)
    @type = :cargo
    super
  end
end
