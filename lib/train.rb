# encoding: UTF-8
require_relative 'route'
require_relative 'station'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'wagon'
require_relative 'main_menu'

class Train
  attr_reader :speed, :num, :wagons, :type, :current_stop
  @@trains = {}

  def initialize(num)
    @num = num
    @speed = 0
    @wagons = []
    @@trains[num] = self
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
# отцепляет последний вагон
  def detach_wagon
    @wagons.pop if @wagons.size > 0 && @speed == 0
  end
# прицепляет вагоны (по одному вагону за операцию, если поезд стоит).
# к пассажирскому поезду цепляются только пассажирские, к грузовому - грузовые. 
  def attach_wagon(wagon)
    #простой include не работает, потому что подкласс добавляет свои метки
    @wagons.each do |attached_wagon|
       return if wagon == attached_wagon
    end
    @wagons << wagon if @speed == 0 && wagon.type == self.type
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
    next_station = next_stop
    next_station.arrival(self)
    @current_stop = next_station
  end

# перемещение назад по маршруту - на 1 станцию за раз.
  def backward
    last_station = last_stop
    last_station.arrival(self)
    @current_stop = last_station
  end

# следующая остановка, остальные вызываются без метода – last_stop, current_stop
  def next_stop
    unless @route == "" || @current_stop.nil? || @current_stop == @route.terminal_station
      next_after(@current_stop)
    end
  end

  def last_stop
    unless @route == "" || @current_stop.nil? || @current_stop == @route.starting_station
      last_before(@current_stop)
    end
  end

  def self.find_train_by_name(name)
    @@trains[name]
  end

# переменная используется только в самом классе и подклассах. человек не знает
# всего маршрута - только текущую, предыдущую и следующую станции
  protected
  attr_reader :route

# методы используются только в классе, нужны для вычисления след/пред станции/
# и (косвенно) продвижения по маршруту вперед/назад. юзеру сами методы не нужны
  private
  def next_after(station)
    @route.full_path.each_cons(2) do |this_station, next_station|
      if station.name == this_station.name
        return next_station
        break
      end
    end
  end

  def last_before(station)
    @route.full_path.each_cons(2) do |last_station, this_station, next_station|
        if @current_stop.name == this_station.name
          return last_station
          break
        end
      end
  end
end
