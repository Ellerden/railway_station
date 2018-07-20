# encoding: UTF-8
require_relative 'station'
require_relative 'main_menu'

class Route
  attr_reader :starting_station, :terminal_station, :full_path
  @@routes = []
# Начальная и конечная станции указываются при создании маршрута,
# а промежуточные могут добавляться между ними.
  def initialize(starting_station, terminal_station)
    if !starting_station.nil? && !terminal_station.nil?
      @full_path = [starting_station, terminal_station]
      @starting_station = starting_station
      @terminal_station = terminal_station
      @@routes << self
    else
      abort "Невозможно построить маршрут — нужны начальная и конечная станции"
    end
  end
# добавлять промежуточную станцию в список (на предпоследнее место)
  def add_station(station)
    unless @full_path.include? station
      @full_path.insert(-2, station)
    end
  end
# удаляет промежуточную станцию из списка
  def delete_station(station)
    # проверяем, является ли станция промежуточной. если да - удаляем
    unless station == @starting_station || station == @terminal_station
      @full_path.delete(station)
    end
  end
# выводит список всех станций по-порядку от начальной до конечной
  def show
    @full_path.each { |station| puts "#{station.name} " }
  end
# показывает все созданные маршруты
  def self.show_all
    unless @@routes.nil?
      @@routes.each_with_index do |route, index|
        puts "№ #{index + 1}"
        puts "................"
        route.show
        puts "................"
      end
    end
  end

  def self.by_index(index)
    @@routes[index - 1]
  end

  protected
  # показывает последний созданный маршрут. нужно для добавления/удаления станции
  # из маршрута через меню (class RouteMenu). юзеру не нужен этот метод
  def self.last
    @@routes.last
  end
  # нужно чтобы знать RouteMenu есть ли какие маршруты показывать или нет
  # конечному пользователю не нужно
  def self.empty?
    @@routes.empty?
  end
end
