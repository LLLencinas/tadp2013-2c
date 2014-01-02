require 'test/unit'
require_relative '../test/clases_para_probar/clase_prueba'
require_relative '../test/clases_para_probar/otra_prueba'
require_relative '../src/join_point_metodos_tipo_de_parametro'


class TipoParametroTest < Test::Unit::TestCase

  def setup
    @jptipo = JoinPointMetodosTipoDeParametro.new(:opt)
  end

  def test_jp_encuentra_metodo_con_parametro_opcional_de_clase_prueba
    metodos = @jptipo.traer_metodos_una_clase(ClasePrueba)
    assert (metodos == [ClasePrueba.instance_method(:metodo_con_parametro_opcional)])
  end

  def test_jp_no_encuentra_metodo_con_parametro_opcional_en_otra_prueba
    metodos = @jptipo.traer_metodos_una_clase(OtraPrueba)
    assert (metodos == [])
  end

end