require_relative 'route'
require_relative 'station'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'wagon'
require_relative 'main_menu'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'wagons_info'
require_relative 'validation'
require_relative 'accessors'

# создание и упраление поездов
class Train
  include Manufacturer
  include InstanceCounter
  include WagonsInfo
  include Validation
  extend Accessors
  # можно создать только объекты субкласса PassengerTrain или CargoTrain
  private_class_method :new
  attr_reader :speed, :num, :wagons, :type, :current_stop
  @@trains = {}

  validate :type, :between_two_types, 'PassengerTrain || CargoTrain'

  def initialize(num, train_manufacturer = nil)
    @num = num
    @speed = 0
    @wagons = []
    self.company_name = train_manufacturer
    register_instance
  end

  # набираeт скорость (по 5 км )
  def accelerate
    @speed += 5
  end

  # тормозит (сбрасывать скорость до нуля)
  def stop
    @speed = 0
  end

  # метод, который принимает блок и проходит по всем вагонам поезда
  def each_wagon
    @wagons.each { |wagon| yield(wagon, @wagons.index(wagon)) }
  end

  # отцепляет последний вагон (по одному вагону за операцию, если поезд стоит).
  def detach_wagon
    @wagons.pop if @speed.zero?
  end

  # прицепляет вагоны (по одному вагону за операцию, если поезд стоит).
  # к пассажирскому поезду цепляются только пассажирские, к грузовому - грузовые
  def attach_wagon(wagon)
    # простой include не работает, потому что подкласс добавляет свои метки
    @wagons.each do |attached_wagon|
      break if wagon.object_id == attached_wagon.object_id
    end
    if @speed.zero? && (@type == PassengerTrain && wagon.is_a?(PassengerWagon) ||
      @type == CargoTrain && wagon.is_a?(CargoWagon))
      @wagons << wagon
    end
  end

  # принимает маршрут следования. При назначении маршрута поезду,
  # поезд автоматически помещается на первую станцию в маршруте.
  def begin_route(route)
    return unless route.is_a? Route
    @route = route
    # validate :route, :type, Route
    # валидируем маршрут - вдруг это не маршрут
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

  def next_stop
    # если маршрутов нет, поезд еще не вышел на маршрут или стоит на конечной
    unless @route == '' || @current_stop.nil? ||
           @current_stop == @route.terminal_station
      next_after(@current_stop)
    end
  end

  def last_stop
    # если маршрутов нет, поезд еще не вышел на маршрут или стоит на 1-й станции
    unless @route == '' || @current_stop.nil? ||
           @current_stop == @route.starting_station
      last_before(@current_stop)
    end
  end

  # поиска поезда по имени
  def self.find(name)
    @@trains[name]
  end

  protected

  strong_attr_accessor :route, Route

  private

  def next_after(station)
    @route.full_path.each_cons(2) do |this_station, next_station|
      return next_station if station.name == this_station.name
    end
  end

  def last_before(station)
    @route.full_path.each_cons(2) do |last_station, this_station, _next_station|
      return last_station if station.name == this_station.name
    end
  end
end
