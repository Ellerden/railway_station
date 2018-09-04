require_relative 'wagon'
require_relative 'validation'
# Создание и управление грузовыми вагонами
class CargoWagon < Wagon
  include Validation
  # возвращает занятый объем - переменная @taken_space
  # возвращает объем  - @capacity
  attr_reader :capacity, :taken_space
  public_class_method :new

  validate :company_name, :presence

  def initialize(manufacturer, capacity)
    @type = self.class
    @capacity = capacity
    @taken_space = 0
    super
    @@all_wagons << self
  end

  def occupy_space(space)
    @taken_space += space unless space + @taken_space > @capacity
  end
end
