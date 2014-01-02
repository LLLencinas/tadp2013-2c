require_relative '../../tp_aspectos/src/join_point'
require_relative '../../tp_aspectos/src/join_point_metodos_enumeracion'
require_relative '../../tp_aspectos/src/join_point_metodos'
require_relative '../../tp_aspectos/src/join_point_clases_enumeracion'
require_relative '../../tp_aspectos/src/join_point_clases'
require_relative '../../tp_aspectos/src/join_point_clases_jerarquia'
require_relative '../../tp_aspectos/src/join_point_clases_expresion_regular'
require_relative '../../tp_aspectos/src/join_point_metodos_accessor'
require_relative '../../tp_aspectos/src/join_point_metodos_aridad'
require_relative '../../tp_aspectos/src/join_point_metodos_expresion_regular'
require_relative '../../tp_aspectos/src/join_point_metodos_nombre_de_parametro'
require_relative '../../tp_aspectos/src/join_point_metodos_tipo_de_parametro'

class CreadorJoinPoint

  #Estos son los metodos que se deberian llamar
  #desde los test. EN la clase desl Test hay
  #ejemplos de como usarlos por si no queda claro

  def aridad (numero)
    @join_point = JoinPointMetodosAridad.new  numero
  end

  def jerarquia (clase)
    @join_point = JoinPointClasesJerarquia.new clase
  end

  def parecida nombreClase
    @join_point = JoinPointClasesExpresionRegular.new nombreClase
  end

  def parecido nombreMetodo
    @join_point = JoinPointMetodosExpresionRegular.new nombreMetodo
  end

  def metodos enumMetodos
    @join_point = JoinPointMetodosEnumeracion.new enumMetodos
  end

  def clases enumClases
    @join_point = JoinPointClasesEnumeracion.new enumClases
  end

  def accessor
    @join_point = JoinPointMetodosAccessor.new
  end

  def parametro nombreParametro
    @join_point = JoinPointMetodosNombreDeParametro.new nombreParametro
  end

  def opcionales
    :opt
  end

  def requeridos
    :req
  end

  def parametros  tipo
    @join_point = JoinPointMetodosTipoDeParametro.new tipo
  end
  def crear_construccion
    @join_point
  end
  def construir
    @join_point
  end

   def tiene (algo)
     algo
   end
    def no (point_cut)
     @join_point=PointCutNot.new(point_cut)
    end
  def es (algo)
    algo
  end
  def a (algo)
    algo
  end
  def de (algo)
    algo
  end
end