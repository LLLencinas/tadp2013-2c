class MetodoArgumentosResultado
  attr_accessor :metodo,:argumentos, :resultado

  def initialize(metodo,argumentos,resultado)
    @metodo = metodo
    @argumentos = argumentos
    @resultado = resultado
  end

  def mismo_metodo_mismos_argumentos(metodo,argumentos)
    (@metodo == metodo) & (@argumentos == argumentos)

  end
end