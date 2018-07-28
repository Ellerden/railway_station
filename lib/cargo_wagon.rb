require_relative 'wagon'
# # Создание и управление грузовыми вагонами
class CargoWagon < Wagon
  # возвращает занятый объем - переменная @taken_space
  # возвращает объем  - @capacity
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
    @taken_space += space unless space + @taken_space > @capacity
  end
end
