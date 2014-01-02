class Cache

  attr_accessor :memoria

  def initialize
    @memoria = []
  end


  def se_ejecuto_previamente?(metodo,argumentos)
      @memoria.any? do |metodo_argumentos_resultado|
        metodo_argumentos_resultado.mismo_metodo_mismos_argumentos(metodo,argumentos)
        end
  end

  def dame_resultado(metodo,argumentos)
    @memoria.find do |metodo_argumentos_resultado|
      metodo_argumentos_resultado.mismo_metodo_mismos_argumentos(metodo,argumentos)
    end.resultado
  end

  def agregar_metodo_argumentos_resultado(metodo_argumento_resultado)
     @memoria << metodo_argumento_resultado
  end
  def limpiar
    @memoria = []
  end
end