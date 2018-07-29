require_relative 'train'
require_relative 'main_menu'
require_relative 'station'
# Интерфейс меню для управления станциями
class StationMenu
  OPTIONS = ['Выберите операцию: 1 - создать станцию, '\
             '2 - посмотреть список поездов на станции. '\
             '3 - посмотреть список всех станций. '\
             '0 - назад'].freeze

  MENU_METHODS = { 1 => :create_station, 2 => :show_trains_on_station,
                   3 => :show_all_stations }.freeze

  def initialize
    puts OPTIONS
  end

  def do_from_menu(choice)
    send MENU_METHODS[choice] || return
  end

  # к этим методам есть доступ только через do_from_menu,
  # используются внутри клаccа

  private

  # создать станцию
  def create_station
    puts 'Введите название станции, которую вы хотите создать'
    name = gets.chomp
    station = Station.new(name)
    puts "Станция #{station.name} создана" if station.valid?
  rescue RuntimeError => e
    puts "Что-то пошло не так, повторите ввод. Ошибка: #{e.inspect}"
    retry
  end

  # список поездов на станции
  def show_trains_on_station
    puts 'Введите название станции, чтобы посмотреть список поездов'
    name = gets.chomp
    selected_station = Station.find_station_by_name(name)
    return if selected_station.nil? && selected_station.trains.nil?
    selected_station.each_train do |train|
      puts "Поезд #{train.num}, тип: #{train.type}, кол-во вагонов: "\
      "#{train.wagons.size}"
    end
  end

  # показать все существующие станции
  def show_all_stations
    puts 'Список всех существующих ж/д станций:'
    puts Station.all
  end
end
