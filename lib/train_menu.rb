require_relative 'route'
require_relative 'station'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'
require_relative 'wagon'
require_relative 'main_menu'
require_relative 'wagons_info'
require_relative 'train'

class TrainMenu
  include WagonsInfo

  def initialize
    puts 'Выберите операцию: 1 - создать поезд, 2 - выбрать маршрут поезда, '\
    '3 - вперед по маршруту, 4 - назад по маршруту, 5 - информация о вагонах. '\
    '0 - назад'
  end

  def do_from_menu(choice)
    case choice
    # создать поезд
    when 1 then create_train
    # выбрать маршрут
    when 2 then choose_route
    # вперед по маршруту
    when 3 then forward_on_route
    # назад по маршруту
    when 4 then backward_on_route
    # управлять вагонами
    when 5 then manage_wagons
    # назад к главному меню
    when 0 then nil
    end
  end

  # к этим методам есть доступ только через do_from_menu,
  # используются внутри клаccа

  private

  def create_train
    puts 'Выберите тип поезда, который вы хотите создать: 1 - пасс, 2 - груз.'
    type = gets.chomp.to_i
    puts 'Введите название поезда, который вы хотите создать'
    name = gets.chomp
    case type
    when 1 then train = PassengerTrain.new(name)
    when 2 then train = CargoTrain.new(name)
    else
      raise 'Неверно задан тип поезда. Повторите ввод'
    end
    puts "Поезд #{train.num} типа #{train.type} создан!" if train.valid?
  rescue RuntimeError => e
    puts "Что-то пошло не так, повторите ввод. Ошибка: #{e.inspect}"
    retry
  end

  def choose_route
    puts 'Какой поезд вы хотите поставить на маршрут? Введите название'
    name = gets.chomp
    selected_train = Train.find(name)
    unless selected_train.nil? || Route.empty?
      puts 'Выберите один из маршрутов: '
      all_routes = Route.all
      puts all_routes
      choice = gets.chomp.to_i
    end
    unless choice.zero? || choice > size
      selected_route = Route.by_index(choice)
      selected_train.begin_route(selected_route)
      puts "Поезд вышел на маршрут № #{choice}!"
    end
  end

  def forward_on_route
    puts 'Какой поезд вы хотите продвинуть вперед? Введите название'
    name = gets.chomp
    selected_train = Train.find(name)
    unless selected_train.nil? || selected_train.current_stop.nil?
      puts "Следующая станция — #{selected_train.next_stop.name}"
      selected_train.forward
      puts 'Поезд отправился вперед'
    end
  end

  def backward_on_route
    puts 'Какой поезд вы хотите отправить назад? Введите название'
    name = gets.chomp
    selected_train = Train.find(name)

    unless selected_train.nil? || selected_train.current_stop.nil?
      puts "Предыдущая станция — #{selected_train.last_stop.name}"
      selected_train.backward
      puts 'Поезд отправился назад'
    end
  end

  def manage_wagons
    puts 'Информацию о вагонах какого поезда вы хотите увидеть? Введите название'
    name = gets.chomp
    selected_train = Train.find(name)
    selected_train.show_wagons_info if selected_train && selected_train.wagons
  end
end
