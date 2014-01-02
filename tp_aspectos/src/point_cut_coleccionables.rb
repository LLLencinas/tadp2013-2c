require_relative '../../tp_aspectos/src/join_point'
class PointCutColeccionables  < JoinPoint

  def initialize(join_points)
    @join_points = join_points
  end

  def traer_metodos_una_clase(clase)
    resultados_join_points = @join_points.collect do |join_point|
      join_point.traer_metodos_una_clase(clase)
    end

    self.combinar_resultados(resultados_join_points)

  end

  def combinar_resultados(una_coleccion)
    una_coleccion.inject(una_coleccion.shift) do |la_coleccion,metodos|
      la_coleccion.send self.tu_metodo, metodos
    end
  end
end