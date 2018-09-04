module Accessors
  # Динамически создаются геттеры и сеттеры, для любого кол-ва атрибутов
  # хранит массив всех значений переменной
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history") { instance_variable_get(var_history) }

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        instance_variable_set(var_history, []) unless instance_variable_get(var_history)
        instance_variable_get("@#{name}_history").push(value)
      end
    end
  end

  # принимает имя атрибута и его класс.
  def strong_attr_accessor(attr_name, attr_type)
    var_name = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(var_name) }
    define_method("#{attr_name}=".to_sym) do |value|
      begin
        raise(ArgumentError, 'InvalidType') unless value.is_a? attr_type
        instance_variable_set(var_name, value)
      rescue ArgumentError => e
        puts "Невозможно присвоить значение. Ошибка: #{e.inspect}"
      end
    end
  end
end
