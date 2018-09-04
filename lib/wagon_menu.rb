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
                   3 => :detach_wagon_from_train }.freeze
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
    case type
    when 1 then create_pass_wagon
    when 2 then create_cargo_wagon
    else
      raise 'Неверно задан тип вагона. Повторите ввод'
    end
  rescue RuntimeError => e
    puts "Что-то пошло не так. Неверный тип вагонов. Ошибка: #{e.inspect}"
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

  def create_cargo_wagon
    puts 'Введите название фирмы-производителя вагонов'
    name = gets.chomp
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
    return unless selected_train
    selected_train.attach_wagon(last_wagon)
    puts 'Вагон прицеплен'
  end

  def detach_wagon_from_train
    puts 'Введите название поезда, от которого отцеплять вагон. '\
    'Будет отцеплен последний вагон в поезде'
    name = gets.chomp
    selected_train = Train.find(name)
    puts "selected_train.wagons #{selected_train.wagons}"
    return unless selected_train && selected_train.wagons
    selected_train.detach_wagon
    puts 'Вагон отцеплен'
  end
end
