# encoding: UTF-8

require_relative 'train'
# Создание и управление грузовыми поездами
class CargoTrain < Train
  def initialize(num)
    @type = :cargo
    super
    @@trains[num] = self
  end
end
