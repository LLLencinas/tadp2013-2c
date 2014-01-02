#'yo diria de hacer algo como
# modificar {si cumple [que] { definicion de los JP} y cumple { otro jp} o cumple { otro jp }
# o para el no: modificar si no cumple {definicion jp} ...}
#osea... modificar si [no] cumple .... y cumple ... o cumple... para los si, no y eso (q pueden estar adentro tmb)
#por lo que habria que hacer dentro de la definicion de los jp pertenece a <unaClase> es parecido a <unMetodo> y
#esas cosas
#algo asi:
#
# modificar {si cumple ....
# haciendo {
# antes {bloque}
# despues {bloque}
# en vez {bloque}
# en error{bloque}
# con cache de mensajes
# }
#aplicado dinamicamente
# }
# opcional cada uno, me parece que es una buena idea. Para esto deberiamos hacer que un aspecto
# se pueda aplicar con varios advices a la vez (coleccion de advices y que .each aplicar) como para dejarlo asi armado
# oooooo tal vez un advice_coleccion que tenga muchos advices y que el aplicar sea el aplicar de cada uno
# dejo las ideas aca y dsp distribuimos las clases en cada lugar pero para encontrarlo junto x ahora
# tambien la idea seria que cuando se ponga el modificar devuelva el aspecto (asi la persona lo puede aplicar o
# desaplicar como quiera)'
require_relative '../../tp_aspectos/src/aspecto'
require_relative '../../tp_aspectos/src/advice'
require_relative '../../tp_aspectos/src/advice_intercepciones'
require_relative '../../tp_aspectos/src/advice_cacheador'
require_relative '../../tp_aspectos/src/aspecto_dsl'
require_relative '../../tp_aspectos/src/constructor_generico_de_cosas_dsl'
class Object
  include Constructor_Dsl
  def tu_clase_a_buildear
    AspectoDsl
  end
  def modificar &bloque_configuracion
    self.construir &bloque_configuracion
  end

end

