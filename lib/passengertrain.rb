require_relative "train"
require_relative "route"
require_relative "station"

class PassengerTrain < Train

  def initialize(num)
    @type = :pass
    super
  end

end
