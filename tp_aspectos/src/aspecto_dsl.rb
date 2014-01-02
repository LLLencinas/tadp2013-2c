require_relative '../../tp_aspectos/src/aspecto'
require_relative '../../tp_aspectos/src/advice'
require_relative '../../tp_aspectos/src/advice_intercepciones'
require_relative '../../tp_aspectos/src/advice_cacheador'
require_relative '../../tp_aspectos/src/advice_dsl'
require_relative '../../tp_aspectos/src/point_cut_dsl'
require_relative '../../tp_aspectos/src/constructor_generico_de_cosas_dsl'

class AspectoDsl
  include Constructor_Dsl #no lo necesita pero esta en object pero lo incluyo de nuevo para indicar que lo voy a usar
  attr_accessor :tu_target
  def tu_clase_a_buildear
    @tu_target
  end
  def initialize
    @dinamicamente=false
  end
  def haciendo &bloque_advice
    @tu_target=AdviceDsl
    @el_advice=self.construir &bloque_advice
  end

  def si &bloque_point_cut
    @tu_target=PointCutDsl
    @el_point_cut=self.construir &bloque_point_cut
  end
  #defino el method_missing porque solo yo le mando mensajes y no quiero que joda con otras cosas para no definir
  #los "pasamanos" que no son necesarios
  def method_missing(meth, *args, &block)

  end
  def dinamicamente
    @dinamicamente=true
  end


  def crear_construccion
    aspecto=Aspecto.new(@el_point_cut,@el_advice)
    aspecto.aplicado_dinamicamente = @dinamicamente
    aspecto
  end
end


