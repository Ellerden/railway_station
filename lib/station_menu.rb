# encoding: UTF-8
require_relative 'train'
require_relative 'main_menu'
require_relative 'station'

class StationMenu
  def initialize
    puts 'Выберите операцию: 1 - создать станцию, 2 - посмотреть список поездов'\
    ' на станции. 0 - назад'
  end

  def do_from_menu(choice)
    case choice
      # создать станцию
    when 1
      puts 'Введите название станции, которую вы хотите создать'
      name = gets.chomp
      station = Station.new(name)
      puts "Станция #{station.name} создана"
      # список поездов на станции
    when 2
      puts 'Введите название станции, чтобы посмотреть список поездов'
      name = gets.chomp
      selected_station = Station.find_station_by_name(name)
      unless selected_station.nil?
        selected_station.show_trains_by_type
      end
      # возврат в главное меню
    when 0
      MainMenu.show
    end
  end
end
