# encoding: UTF-8

require_relative 'wagon'
# Создание и управление пассажирскими вагонами
class PassengerWagon < Wagon
  def initialize(manufacturer)
    @type = :pass
    super
  end
end
