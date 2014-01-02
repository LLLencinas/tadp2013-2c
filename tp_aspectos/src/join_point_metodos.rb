require_relative '../src/join_point'
class JoinPointMetodos < JoinPoint

  def traer_metodos_una_clase(clase)

    self.evaluar_metodos(super)

  end

  def evaluar_metodos(metodos)
    metodos.select do |metodo| self.evaluar(metodo)
    end
  end

end


