# encoding: UTF-8

require_relative 'wagon'
# # Создание и управление грузовыми вагонами
class CargoWagon < Wagon
  # возвращает занятый объем - переменная @taken_space
  # возвращает оставшийся (доступный) объем  - @capacity
  attr_reader :capacity, :taken_space
  public_class_method :new

  def initialize(manufacturer, capacity)
    @type = :cargo
    @capacity = capacity
    @taken_space = 0
    super
    @@all_wagons << self
  end

  def occupy_space(space)
    unless space > @capacity
      @taken_space += space
      @capacity -= space
    end
  end
end
