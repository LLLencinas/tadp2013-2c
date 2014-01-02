require_relative '../src/join_point_metodos'

class JoinPointMetodosAccessor < JoinPointMetodos

  def evaluar(metodo)

    if /^[a-z_]([a-zA-Z_0-9]*)=$/.match(metodo.name.to_s)
      self.esta_el_otro_accessor?(:getter,metodo)
    else
      if /^[a-z_]/.match(metodo.name.to_s)
        self.esta_el_otro_accessor?(:setter,metodo)
      end
    end
  end

  def esta_el_otro_accessor?(simbolo_buscado, metodo)      #Es medio feito esto...
    todos_los_nombres = metodo.owner.instance_methods(false).collect do |simbolo| simbolo.to_s end
    nombre = metodo.name.to_s
    resultado = false

    if(simbolo_buscado == :setter)
      resultado = todos_los_nombres.include?(nombre + '=')
    end
    if(simbolo_buscado == :getter)
      resultado = todos_los_nombres.include?(nombre.delete('='))
    end

    resultado

  end

end