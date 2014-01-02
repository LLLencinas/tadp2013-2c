require_relative '../src/join_point'
class PointCutNot  < JoinPoint
  # To change this template use File | Settings | File Templates.

  def initialize(join_point)
    @join_point = join_point
  end

  def traer_metodos_una_clase(clase)

    todos_los_metodos_de_la_clase = super
    respuesta_join_point = @join_point.traer_metodos_una_clase(clase)

    todos_los_metodos_de_la_clase - respuesta_join_point
  end

end