require_relative '../test/clases_para_probar/solo_accessors'
require_relative '../test/clases_para_probar/accessors_a_mano_y_otros'
require_relative '../src/join_point_metodos_accessor'
require_relative '../test/clases_para_probar/clase_con_operadores_logicos'
require 'test/unit'

class AccessorTest < Test::Unit::TestCase


  def setup
    @jpaccessor = JoinPointMetodosAccessor.new()
  end

  def test_jp_trae_los_accessors_de_clase_solo_accessors
    metodos = @jpaccessor.traer_metodos_una_clase(SoloAccessors)
    metodos_assert = SoloAccessors.instance_methods(false).collect do |simbolo| SoloAccessors.instance_method(simbolo) end
    assert (metodos == metodos_assert)
  end

  def test_jp_trae_solamente_los_accessors_de_clase_accessors_a_mano_y_otros
    metodos = @jpaccessor.traer_metodos_una_clase(AccessorsAManoYOtros)
    metodos_assert = [AccessorsAManoYOtros.instance_method(:atributo),AccessorsAManoYOtros.instance_method(:atributo=)]
    assert (metodos == metodos_assert)
  end

  def test_jp_no_trae_ningun_operador_de_comparacion
    metodos = @jpaccessor.traer_metodos_una_clase(ClaseConOperadoresLogicos)
    assert metodos == []
  end

end