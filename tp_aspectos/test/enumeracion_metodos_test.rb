require 'test/unit'
require_relative '../test/clases_para_probar/clase_prueba'
require_relative '../test/clases_para_probar/otra_prueba'
require_relative '../src/join_point_metodos_enumeracion'

class EnumeracionMetodosTest < Test::Unit::TestCase


  def setup
    @jpenumeracion = JoinPointMetodosEnumeracion.new(%w(metodo_aridad_2 nombre_que_ningun_metodo_tiene metodo_en_clase_otra_prueba))
    @jpenumeracionvacia = JoinPointMetodosEnumeracion.new([])
  end

  def test_jp_enumeracion_vacia
    metodos = @jpenumeracionvacia.traer_metodos_una_clase(ClasePrueba)
    assert metodos == []
  end

  def test_jp_enumeracion_metodos_encuentra_metodo_enumerado_de_clase_prueba
    metodos = @jpenumeracion.traer_metodos_una_clase(ClasePrueba)
    assert (metodos == [ClasePrueba.instance_method(:metodo_aridad_2)])
  end

  def test_jp_enumeracion_metodos_encuentra_metodo_enumerado_de_otra_prueba
    metodos = @jpenumeracion.traer_metodos_una_clase(OtraPrueba)
    assert (metodos == [OtraPrueba.instance_method(:metodo_en_clase_otra_prueba)])
  end


end