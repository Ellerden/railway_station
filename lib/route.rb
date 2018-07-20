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
    @full_path.each { |station| puts "#{station.name} "}
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

  def self.menu
    "Выберите операцию: 1 - создать маршрут, 2 - добавить станцию, "\
    "3 - удалить станцию, 4 - посмотреть список всех станций, 0 - назад"
  end

  def self.do_from_menu(choice)
    case choice

      # 1 - создать маршрут
      when 1
        puts "Введите начальную станцию"
        start = gets.chomp
        starting_station = Station.find_station_by_name(start)
        # если такой станции нет, она будет создана
        unless starting_station.nil?
          starting_station = Station.new(start)
        end
        puts "Введите конечную станцию"
        finish = gets.chomp
        terminal_station = Station.find_station_by_name(finish)
        # если такой станции нет, она будет создана
        unless terminal_station.nil?
          terminal_station = Station.new(finish)
        end
        @@routes << new(starting_station, terminal_station)
        puts "Маршрут от #{start} до #{finish} создан"

      # 2 - добавить станцию
      when 2
        puts "Введите название станции, которую хотите добавить. "\
        "Станция будет добавлена в последний созданный маршрут"
        name = gets.chomp
        additional_station = Station.find_station_by_name(name)
        # если такой станции нет, она будет создана
        unless additional_station.nil?
          additional_station = Station.new(name)
          @@routes.last.add_station(additional_station)
          puts "Станция #{name} добавлена!"
        end

        # 3 - удалить станцию
      when 3
        puts "Введите название станции, которую хотите удалить. "\
        "Станция будет удалена из последнего созданного маршрута"
        name = gets.chomp

        odd_station = Station.find_station_by_name(name)
        unless odd_station.nil?
          odd_station = Station.new(name)
          @@routes.last.delete_station(odd_station)
          puts "На станции #{name} поезд больше не остановится"
        end

      # 4 - посмотреть список всех станций,
      when 4
        puts "Информация о последнем добавленном маршруте:"
        unless @@routes.empty?
          @@routes.last.show
        end

      when 0
        MainMenu.show
      end
  end

  private
  attr_reader :routes
end
