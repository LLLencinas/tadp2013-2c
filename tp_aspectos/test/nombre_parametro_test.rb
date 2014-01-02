require 'test/unit'
require_relative '../test/clases_para_probar/clase_prueba'
require_relative '../test/clases_para_probar/otra_prueba'
require_relative '../src/join_point_metodos_nombre_de_parametro'


class NombreParametroTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @jpparametro = JoinPointMetodosNombreDeParametro.new('parametro1')
  end

  def test_jp_encuentra_metodo_aridad_2_de_clase_prueba_porque_tiene_parametro1
    metodos = @jpparametro.traer_metodos_una_clase(ClasePrueba)
    assert (metodos == [ClasePrueba.instance_method(:metodo_aridad_2)])
  end

  def test_jp_no_encuentra_metodos_en_otra_prueba_porque_ninguno_tiene_parametro1
    metodos = @jpparametro.traer_metodos_una_clase(OtraPrueba)
    assert (metodos == [])
  end


end