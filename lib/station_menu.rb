# encoding: UTF-8

require_relative 'train'
require_relative 'main_menu'
require_relative 'station'
# Интерфейс меню для управления станциями
class StationMenu
  def initialize
    puts 'Выберите операцию: 1 - создать станцию, 2 - посмотреть список поездов'\
    ' на станции. 3 - посмотреть список всех станций. 0 - назад'
  end

  def do_from_menu(choice)
    case choice
      # создать станцию
    when 1 then create_station
      # список поездов на станции
    when 2 then show_trains_on_station
      # показать все существующие станции
    when 3 then show_all_stations
      # возврат в главное меню
    when 0 then return
    end
  end
  # к этим методам есть доступ только через do_from_menu,
  # используются внутри клаccа

  private

  def create_station
    puts 'Введите название станции, которую вы хотите создать'
    name = gets.chomp
    station = Station.new(name)
    puts "Станция #{station.name} создана"
  end

  def show_trains_on_station
    puts 'Введите название станции, чтобы посмотреть список поездов'
    name = gets.chomp
    puts 'Поезда какого типа показать? 1 - пасс, 2 - груз, 3 - все'
    type = gets.chomp.to_i
    case type
    when 1 then type = :pass
    when 2 then type = :cargo
    when 3 then type = :all
    else
      puts 'Такой тип поездов пока нам неизвестен'
    end

    selected_station = Station.find_station_by_name(name)
    puts selected_station.trains_by_type(type) unless selected_station.nil?
  end

  def show_all_stations
    puts 'Список всех существующих ж/д станций:'
    puts Station.all
  end
end
