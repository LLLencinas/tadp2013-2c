require_relative '../test/clases_para_probar/accessors_a_mano_y_otros'
require_relative '../src/join_point_metodos_expresion_regular'
require 'test/unit'


class ExpresionRegularMetodosTest < Test::Unit::TestCase

  def setup
    @jpexpresion_metodo = JoinPointMetodosExpresionRegular.new(/metodo/)
    @jpexpresion_lalalala = JoinPointMetodosExpresionRegular.new(/lalalala/)
  end

  def test_jp_trae_metodos_que_cumplen_expresion_regular_de_clase_accessors_a_mano_y_otros
    metodos = @jpexpresion_metodo.traer_metodos_una_clase(AccessorsAManoYOtros)
    assert metodos == [AccessorsAManoYOtros.instance_method(:metodo_no_accessor)]
  end

  def test_jp_no_trae_metodos_de_esta_clase_porque_no_cumplen_expresion_regular
    metodos = @jpexpresion_lalalala.traer_metodos_una_clase(ExpresionRegularMetodosTest)
    assert metodos == []
  end


end