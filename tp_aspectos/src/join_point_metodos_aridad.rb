require_relative '../src/join_point_metodos'

class JoinPointMetodosAridad < JoinPointMetodos

  def initialize(aridad)
    @aridad = aridad
  end

  def evaluar(metodo)
    #no uso .arity porque hace lio con los opt
    @aridad == metodo.parameters.size
  end

end