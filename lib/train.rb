# encoding: UTF-8

require_relative 'route'
require_relative 'station'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'wagon'
require_relative 'main_menu'
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'wagons_info'

# создание и упраление поездов
class Train
  include Manufacturer
  include InstanceCounter
  include WagonsInfo
  # можно создать только объекты субкласса PassengerTrain или CargoTrain
  private_class_method :new
  attr_reader :speed, :num, :wagons, :type, :current_stop
  @@trains = {}

  def initialize(num, train_manufacturer = nil)
    @num = num
    @speed = 0
    @wagons = []
    self.company_name = train_manufacturer
    validate!
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

  #метод, который принимает блок и проходит по всем вагонам поезда
  #(вагоны должны быть во внутреннем массиве), передавая каждый объект вагона в блок.

  def show_all_wagons(&block)
    @wagons.each { |wagon| block.call(wagon, @wagons.index(wagon) + 1) }
  end

  # отцепляет вагоны (по одному вагону за операцию, если поезд стоит).
  # отцепляет последний вагон
  def detach_wagon
    @wagons.pop if @wagons.!empty? && @speed.zero?
  end

  # прицепляет вагоны (по одному вагону за операцию, если поезд стоит).
  # к пассажирскому поезду цепляются только пассажирские, к грузовому - грузовые
  def attach_wagon(wagon)
    #простой include не работает, потому что подкласс добавляет свои метки
    @wagons.each do |attached_wagon|
      return if wagon == attached_wagon
    end
    @wagons << wagon if @speed.zero? && wagon.type == type
    # валидируем вагоны - вдруг это не вагоны
  end

# принимает маршрут следования. При назначении маршрута поезду,
# поезд автоматически помещается на первую станцию в маршруте.
  def begin_route(route)
    @route = route
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

# следующая остановка, остальные вызываются без метода – last_stop, current_stop
  def next_stop
    # если маршрутов нет, поезд еще не вышел на маршрут или стоит на последней станции
    unless @route == '' || @current_stop.nil? || @current_stop == @route.terminal_station
      next_after(@current_stop)
    end
  end

  def last_stop
    # если маршрутов нет, поезд еще не вышел на маршрут или стоит на 1-й станции
    unless @route == '' || @current_stop.nil? || @current_stop == @route.starting_station
      last_before(@current_stop)
    end
  end
 # поиска поезда по имени
  def self.find(name)
    @@trains[name]
  end

# переменная используется только в самом классе и подклассах. человек не знает
# всего маршрута - только текущую, предыдущую и следующую станции

  def valid?
    begin
      validate!
      true
    rescue RuntimeError => e
      puts "Что-то пошло не так, повторите ввод. Ошибка: #{e.inspect}"
      false
    end
  end

  protected

  attr_reader :route

# методы используются только в классе, нужны для вычисления след/пред станции/
# и (косвенно) продвижения по маршруту вперед/назад. юзеру сами методы не нужны

  def validate!
    # regexp формат: 3 буквы или цифры в любом порядке, необязательный дефис
    # и еще 2 буквы или цифры после дефиса
    if @num.match(/^[[:alpha:]\d]{3}-?[[:alpha:]\d]{2}$/i).nil?
      raise 'Неверно задан № поезда. Формат: 3 буквы/цифры(-)2 буквы/цифры'
    end
    raise 'К поезду прикреплены вагоны неверного типа' unless wagons_valid?
    raise 'Маршрут задан неверно' unless route_valid?
    raise 'Неверно задан тип поезда. Нужно - пасс/груз' unless type_valid?
  end

  def wagons_valid?
    selected_wagons = @wagons.select { |wagon| wagon.type == :pass }
    return true if selected_wagons.size == @wagons.size
    false
  end

  def route_valid?
    return true unless @route
    @route.is_a?(Route)
  end

  def type_valid?
    return true if @type == :pass || @type == :cargo
    false
  end

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
