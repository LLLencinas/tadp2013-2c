require_relative '../../tp_aspectos/src/aspecto'
require_relative '../../tp_aspectos/src/advice'
require_relative '../../tp_aspectos/src/advice_intercepciones'
require_relative '../../tp_aspectos/src/advice_cacheador'
require_relative '../../tp_aspectos/src/advice_coleccion'
class AdviceDsl
  def initialize
    @advice_intercepciones=AdviceIntercepciones.new()
    @advice_coleccion=AdviceColeccion.new
    @advice_coleccion.agregar_advice(@advice_intercepciones)
  end
  def antes &un_bloque
    @advice_intercepciones.before=crear_bloque_intersepcion(&un_bloque)
  end

  def vez &un_bloque
    @advice_intercepciones.instead_of =crear_bloque_intersepcion(&un_bloque)
  end
  def despues &un_bloque
    @advice_intercepciones.after=crear_bloque_intersepcion(&un_bloque)
  end

  def error &un_bloque
    @advice_intercepciones.on_error=crear_bloque_intersepcion(&un_bloque)
  end
  #modifico el method_missing para q no joda con los mensajes que no encuentra dado que
  # cualquier mensaje q le mande yo esta controlado y nadie mas puede mandarle mensajes
 # def method_missing(meth, *args, &block)

  #end
  def cache (*args)
    @advice_coleccion.agregar_advice(AdviceCacheador.new)
  end

  def crear_bloque_intersepcion(&unBloque)
    Proc.new { |instancia,*params| unBloque.call(instancia, *params) }
  end
  def en (algo)
    algo
  end
  def con (algo)
    algo
  end


  def crear_construccion
      @advice_coleccion
  end



end