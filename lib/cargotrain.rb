require_relative "train"
require_relative "route"
require_relative "station"
require_relative "passengerwagon"
require_relative "cargowagon"
require_relative "wagon"

class CargoTrain < Train

  def initialize(num)
    @type = :cargo
    super
  end

end
