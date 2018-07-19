require_relative "train"

class PassengerTrain < Train

  def initialize(num)
    @type = :pass
    super
  end

end
