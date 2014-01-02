require_relative '../../tp_aspectos/src/point_cut_and'
require_relative '../../tp_aspectos/src/point_cut_or'
require_relative '../../tp_aspectos/src/point_cut_not'
require_relative '../../tp_aspectos/src/point_cut_acumulador'
require_relative '../../tp_aspectos/src/creador_join_point'
require_relative '../../tp_aspectos/src/constructor_generico_de_cosas_dsl'


#el creador de joinpoint recibe un bloque y entiende los mensajes estandard que definamos nosotros para cada
#clase de joinpoint, por ej: es de clase (nombre de una clase) lo haria como JoinPointEnumeracionClases.new(nombre de la clase)
#esto falta implementarlo
class PointCutDsl
  def tu_clase_a_buildear
    CreadorJoinPoint
  end
  def initialize
    @point_cut_acumulador=PointCutAcumulador.new
  end
  def y &bloque_nuevo_pc
    joinpoint = self.crear_jp &bloque_nuevo_pc
    acumular_en(PointCutAnd,joinpoint)
  end
  def o &bloque_nuevo_pc
    joinpoint = self.crear_jp &bloque_nuevo_pc
    acumular_en(PointCutOr,joinpoint)
  end
  def acumular_en(clase, point_cut)
    acumulado=@point_cut_acumulador.acumulado
    @point_cut_acumulador.acumulado=clase.new([acumulado, point_cut])
  end



# ejemplo: cumple {es de clase Persona}
  def cumple &creador_join_point
    jpcreado = crear_jp(&creador_join_point)
    acumular_jp(jpcreado)
    jpcreado
  end

  def crear_jp(&creador_join_point)
    self.construir &creador_join_point
    #join_point=CreadorJoinPoint.new
    #join_point.instance_eval &creador_join_point
    #jpcreado=join_point.crear_jp
  end

  def acumular_jp(jpcreado)
    if (!@point_cut_acumulador.tiene_acumulado?) then
      @point_cut_acumulador.acumular jpcreado
    end
  end

#que es un mensaje opcional para cumple ("cumple algo" o bien "cumple que algo")
# (metodo no disponible temporalmente)
  #def que &bloque
  #  bloque
  #end

  def crear_construccion
    @point_cut_acumulador.acumulado
  end

  def tiene (algo)
    algo
  end
end