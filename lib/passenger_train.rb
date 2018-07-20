#encoding: UTF-8
require_relative 'train'

class PassengerTrain < Train
  def initialize(num)
    @type = :pass
    super
    @@trains[num] = self
  end
end
