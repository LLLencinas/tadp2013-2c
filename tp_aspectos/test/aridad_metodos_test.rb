require_relative '../test/clases_para_probar/otra_prueba'
require_relative '../test/clases_para_probar/clase_prueba'
require_relative '../src/join_point_metodos_aridad'
require 'test/unit'

class AridadMetodosTest < Test::Unit::TestCase

  def setup
    @jparidad = JoinPointMetodosAridad.new(2)
  end

  def test_jp_aridad_encuentra_metodo_aridad_2
    metodos = @jparidad.traer_metodos_una_clase(ClasePrueba)
    assert (metodos == [ClasePrueba.instance_method(:metodo_aridad_2),ClasePrueba.instance_method(:metodo_con_parametro_opcional)])
  end


  def test_jp_aridad_no_encuentra_metodo_aridad_2
    metodos = @jparidad.traer_metodos_una_clase(OtraPrueba)
    assert (metodos == [])
  end

end