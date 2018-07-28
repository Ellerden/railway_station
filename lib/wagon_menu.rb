require_relative 'train'
require_relative 'main_menu'
require_relative 'wagon'

class WagonMenu
  def initialize
    puts 'Выберите операцию: 1 - создать вагон, 2 - прицепить вагон к поезду, '\
    '3 - отцепить вагон от поезда. 0 - назад'
  end

  def do_from_menu(choice)
    case choice
      # создать вагон
    when 1 then create_wagon
      # добавить вагон к поезду
    when 2 then attach_wagon_to_train
      # отцепить вагон от поезда
    when 3 then detach_wagon_from_train
      # возвращаемся в главное меню ж/д станции
    when 0 then nil
    end
  end
  # к этим методам есть доступ только через do_from_menu,
  # используются внутри клаccа

  private

  def create_wagon
    puts 'Выберите тип вагона, который вы хотите создать: 1 - пасс, 2 - груз'
    type = gets.chomp.to_i
    puts 'Введите название фирмы-производителя вагонов'
    name = gets.chomp
    case type
    when 1
      puts 'Введите количество мест в вагоне'
      places = gets.chomp.to_i
      wagon = PassengerWagon.new(name, places)
    when 2
      puts 'Введите общий объем вагона (м^3)'
      capacity = gets.chomp.to_i
      wagon = CargoWagon.new(name, capacity)
    else
      raise 'Неверно задан тип вагона. Повторите ввод.'
    end
    puts "Вагон #{wagon.company_name} типа #{wagon.type} создан!" if wagon.valid?
  rescue RuntimeError => e
    puts "Что-то пошло не так. Ошибка: #{e.inspect}"
    retry
  end

  def attach_wagon_to_train
    puts 'Введите название поезда, к которому цеплять вагон. '\
    ' К поезду будет прицеплен последний созданный вагон'
    name = gets.chomp
    selected_train = Train.find(name)
    last_wagon = Wagon.last
    if selected_train && selected_train.type == last_wagon.type
      selected_train.attach_wagon(last_wagon)
      puts 'Вагон прицеплен'
    end
  end

  def detach_wagon_from_train
    puts 'Введите название поезда, от которого отцеплять вагон. '\
    'Будет отцеплен последний вагон в поезде'
    name = gets.chomp
    selected_train = Train.find(name)
    if selected_train && selected_train.wagons
      selected_train.detach_wagon
      puts 'Вагон отцеплен'
    end
  end
end
