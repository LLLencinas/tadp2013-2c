require_relative '../../src/aspecto'

class AspectoMock < Aspecto

  attr_accessor :nombres_metodos_nuevos
    def initialize(pc,advice_que_no_importa)
      super
      @nombres_metodos_nuevos = []
    end
  def aplicar_advice(metodos)

  end
  def procesar_metodo_agregado_dinamicamente(metodo)

    if @point_cut.evaluar(metodo)
      @nombres_metodos_nuevos << metodo.name
    end

  end

end