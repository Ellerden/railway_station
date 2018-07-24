# encoding: UTF-8

require_relative 'wagon'
# # Создание и управление грузовыми вагонами
class CargoWagon < Wagon
  public_class_method :new

  def initialize(manufacturer)
    @type = :cargo
    super
    @@all_wagons << self
  end
end
