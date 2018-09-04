# валидация
module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validation_choice

    def validate(name, validation_type, param = nil)
      # параметры валидации заносятся в хэш
      @validation_choice ||= []
      @validation_choice << { attr: name, type: validation_type, param: param }
    end
  end

  module InstanceMethods
    #  Запускает все проверки, указанные в классе ч/з метод класса validate.
    # В случае ошибки валидации выбрасывает исключение с сообщением о том,
    # какая именно валидация не прошла
    def validate!
      self.class.validation_choice.each do |choice|
        validation_method = ('validate_' + choice[:type].to_s).to_sym
        send(validation_method, choice[:attr], choice[:param])
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError => e
      puts "Что-то пошло не так. Ошибка: #{e.inspect}"
      false
    end

    private

    # - требует, чтобы значение атрибута было не nil и не пустой строкой.
    def validate_presence(name, _params)
      value = instance_variable_get("@#{name}")
      raise "#{name} не может быть пустым" if value.nil? || value.to_s.empty?
    end

    #  Треубет соответствия значения атрибута заданному регулярному выражению.
    # (отдельным параметром задается регулярное выражение для формата).
    def validate_format(name, format_value)
      value = instance_variable_get("@#{name}")
      raise "Формат #{name} задан неверно" unless value =~ format_value
    end

    # Требует соответствия значения атрибута заданному классу.
    #  отдельный параметр - класс атрибута).
    def validate_type(name, type)
      value = instance_variable_get("@#{name}")
      raise "Неверный тип #{name}. Должно быть #{type}" unless value.is_a? type
    end

    def validate_between_many_types(name, types)
      value = instance_variable_get("@#{name}")
      types = types.split(' || ')
      types.each { |type| return true if value.is_a? Object.const_get(type) }
      raise "Неверный тип #{name}. Должен быть один из: #{types}"
    end

    def validate_each_type(name, type)
      value = instance_variable_get("@#{name}")
      unless value.all? { |element| element.is_a? type }
        raise "Неверный тип. Все #{name} должны быть типа #{type}"
      end
    end
  end
end
