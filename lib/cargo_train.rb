require_relative 'train'
# Создание и управление грузовыми поездами
class CargoTrain < Train
  public_class_method :new

  def initialize(num)
    @type = :cargo
    super
    @@trains[num] = self
  end
end
