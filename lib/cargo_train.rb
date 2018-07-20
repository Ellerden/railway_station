#encoding: UTF-8
require_relative 'train'

class CargoTrain < Train
  def initialize(num)
    @type = :cargo
    super
    @@trains[num] = self
  end
end
