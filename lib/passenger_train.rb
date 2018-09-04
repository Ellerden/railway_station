require_relative 'train'
require_relative 'validation'
# Создание и управление пассажирскими поездами
class PassengerTrain < Train
  include Validation
  public_class_method :new

  validate :num, :presence
  validate :num, :format, /^[a-z0-9]{3}-{0,1}[a-z0-9]{2}$/i
  validate :wagons, :each_type, PassengerWagon

  def initialize(num)
    @type = self.class
    super
    @@trains[num] = self
  end
end
