# encoding: UTF-8

require_relative 'train'
# Создание и управление пассажирскими поездами
class PassengerTrain < Train
  public_class_method :new

  def initialize(num)
    @type = :pass
    super
    @@trains[num] = self
  end
end
