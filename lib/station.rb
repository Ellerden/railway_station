# encoding: UTF-8
require_relative 'train'
require_relative 'main_menu'

class Station
  attr_reader :name, :trains
  @@stations = {}

  def initialize(name)
    @name = name
    @trains = []
    @@stations[name] = self
  end
# список всех поездов на станции, находящиеся в текущий момент
# список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def show_trains_by_type(type = :all)
    selected_trains = @trains.select { |train| train.type == type || type == :all }
    if selected_trains.empty?
      puts "На станции #{self.name} нет поездов типа #{type}"
      return
    end
    selected_trains.each do |train|
      puts "Поезд: #{train.num}, тип: #{train.type}"
    end
  end
# принимает поезда (по одному за раз)
  def arrival(train)
    unless trains.include? train
      trains << train
    end
  end
# отправляет поезда (по одному за раз. поезд удаляется из списка поездов)
  def departure(train)
    trains.delete(train)
  end

  def self.find_station_by_name(name)
    @@stations[name]
  end

  def self.menu
    "Выберите операцию: 1 - создать станцию, 2 - посмотреть список поездов"\
    " на станции. 0 - назад"
  end

  def self.do_from_menu(choice)
    case choice

      # создать станцию
      when 1
        puts 'Введите название станции, которую вы хотите создать'
        name = gets.chomp
        @@stations[name] = Station.new(name)
        puts "Станция #{name} создана"

      # список поездов на станции
      when 2
        puts 'Введите название станции, чтобы посмотреть список поездов'
        name = gets.chomp
        selected_station = self.find_station_by_name(name)
        unless selected_station.nil?
          selected_station.show_trains_by_type
        end

      when 0
        MainMenu.show
    end
  end

# переменная trains - используется только в методах класса,
# юзер может посмотреть поезда на станции через show_trains_by_type
# к массиву trains напрямую доступ юзеру не нужен
  private
  attr_reader :trains
end
