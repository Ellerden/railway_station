require_relative 'train'
require_relative 'main_menu'
require_relative 'wagon'
# создание и управление вагонами
class WagonMenu
  OPTIONS = ['Выберите операцию: 1 - создать вагон, '\
             '2 - прицепить вагон к поезду, '\
             '3 - отцепить вагон от поезда. '\
             '0 - назад'].freeze
  MENU_METHODS = { 1 => :create_wagon,
                   2 => :attach_wagon_to_train,
                   3 => :delete_station_from_route,
                   4 => :detach_wagon_from_train }.freeze
  WAGON = { 1 => :create_pass_wagon, 2 => :create_cardo_wagon }.freeze
  def initialize
    puts OPTIONS
  end

  def do_from_menu(choice)
    send MENU_METHODS[choice] || return
  end
  # к этим методам есть доступ только через do_from_menu,
  # используются внутри клаccа

  private

  def create_wagon
    puts 'Выберите тип вагона, который вы хотите создать: 1 - пасс, 2 - груз'
    type = gets.chomp.to_i
    send WAGON[type] || raise
  rescue RuntimeError
    puts 'Что-то пошло не так. Неверный тип вагонов'
    retry
  end

  def create_pass_wagon
    puts 'Введите название фирмы-производителя вагонов'
    name = gets.chomp
    puts 'Введите количество мест в вагоне'
    places = gets.chomp.to_i
    wagon = PassengerWagon.new(name, places)
    puts "Вагон типа #{wagon.type} создан и ждет пассажиров" if wagon.valid?
  end

  def create_cardo_wagon
    name = puts 'Введите название фирмы-производителя вагонов'
    gets.chomp
    puts 'Введите общий объем вагона (м^3)'
    capacity = gets.chomp.to_i
    wagon = CargoWagon.new(name, capacity)
    puts "Вагон типа #{wagon.type} создан и готов возить грузы" if wagon.valid?
  end

  def attach_wagon_to_train
    puts 'Введите название поезда, к которому цеплять вагон. '\
    ' К поезду будет прицеплен последний созданный вагон'
    name = gets.chomp
    selected_train = Train.find(name)
    last_wagon = Wagon.last
    return unless selected_train && selected_train.type == last_wagon.type
    selected_train.attach_wagon(last_wagon)
    puts 'Вагон прицеплен'
  end

  def detach_wagon_from_train
    puts 'Введите название поезда, от которого отцеплять вагон. '\
    'Будет отцеплен последний вагон в поезде'
    name = gets.chomp
    selected_train = Train.find(name)
    return unless selected_train && selected_train.wagons
    selected_train.detach_wagon
    puts 'Вагон отцеплен'
  end
end
