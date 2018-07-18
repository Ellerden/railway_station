#encoding: UTF-8
require_relative "station"

class Route
  attr_accessor :full_path, :starting_station, :terminal_station
# Начальная и конечная станции указываются при создании маршрута,
# а промежуточные могут добавляться между ними.
  def initialize(*args)
    @full_path = []
    @full_path = args
    if @full_path.size < 2
      abort "Невозможно построить маршрут — нужны начальная и конечная станции"
    end
    starting_station
    terminal_station
  end

  def starting_station
    @starting_station = @full_path.first
  end

  def terminal_station
    @starting_station = @full_path.last
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
    puts "Маршрут следования: "
    @full_path.map { |station| puts "#{station.name}"}
  end

end
