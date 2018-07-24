# encoding: UTF-8

require_relative 'wagon'
# Создание и управление пассажирскими вагонами
class PassengerWagon < Wagon
  public_class_method :new

  def initialize(manufacturer)
    @type = :pass
    super
    @@all_wagons << self
  end
end
