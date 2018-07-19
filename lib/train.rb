#encoding: UTF-8

require_relative "route"
require_relative "station"

class Train
  attr_accessor :speed, :num, :type, :waggonage, :route, :current_stop,
  :last_stop

  def initialize(num, type = :pass, waggonage)
    @num = num
    @type = type
    @waggonage = waggonage
    @speed = 0
  end
# набираeт скорость (по 5 км )
  def accelerate
    @speed += 5
  end
#тормозит (сбрасывать скорость до нуля)
  def stop
    @speed = 0
  end

# отцепляет вагоны (по одному вагону за операцию, если поезд стоит).
  def detach_car
    @waggonage -= 1 if @speed == 0 && @waggonage > 0
  end
# прицепляет вагоны (по одному вагону за операцию, если поезд стоит).
  def attach_car
    @waggonage += 1 if @speed == 0
  end
# принимает маршрут следования. При назначении маршрута поезду,
# поезд автоматически помещается на первую станцию в маршруте.
  def begin_route(route)
    @route = route
    route.starting_station.arrival(self)
    @current_stop = route.starting_station
  end
# перемещение вперед по маршруту - на 1 станцию за раз.
  def forward
    unless @route == "" || @current_stop == @route.terminal_station
      @route.full_path.each_cons(2) do |this_station, next_station|
        if @current_stop.name == this_station.name
          next_station.arrival(self)
          @last_stop = current_stop
          @current_stop = next_station
          break
        end
      end
    end
  end
# перемещение назад по маршруту - на 1 станцию за раз.
  def backward
    unless @route == "" || @current_stop == @route.starting_station
      @route.full_path.each_cons(2) do |last_station, this_station, next_station|
        if @current_stop.name == this_station.name
          last_station.arrival(self)
          @last_stop = current_stop
          @current_stop = last_station
          break
        end
      end
    end
  end
# следующая остановка, остальные вызываются без метода – last_stop, current_stop
  def next_stop
    unless @route == "" || @current_stop == nil ||
      @current_stop == @route.terminal_station
      @route.full_path.each_cons(2) do |this_station, next_station|
        if @current_stop.name == this_station.name
          return next_station
          break
        end
      end
    end
  end
end
