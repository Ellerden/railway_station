# encoding: UTF-8

require_relative 'train'
# Создание и управление пассажирскими поездами
class PassengerTrain < Train
  def initialize(num)
    @type = :pass
    super
    @@trains[num] = self
  end
end
