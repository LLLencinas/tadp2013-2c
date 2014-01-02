require 'test/unit'
require_relative '../src/join_point_clases_expresion_regular'
require_relative '../test/clases_para_probar/clase_prueba'
require_relative '../test/clases_para_probar/otra_prueba'

class ExpresionRegularClasesTest < Test::Unit::TestCase

  attr_accessor :jpexpresion

  def setup
    @clases_sistema = [OtraPrueba, ClasePrueba]
    @jpexpresion_metodo = JoinPointClasesExpresionRegular.new(/Clase/)
  end

  def test_jp_expresion_regular_encuentra_clase
    es_clase_interesante = @jpexpresion_metodo.evaluar(ClasePrueba)
    assert es_clase_interesante
  end

  def test_jp_expresion_regular_no_encuentra_clase
    es_clase_interesante = @jpexpresion_metodo.evaluar(OtraPrueba)
    assert !es_clase_interesante
  end

  def test_jp_expresion_de_clases_trae_metodos_de_la_clase_enumeracion_clases_test
    metodos = @jpexpresion_metodo.traer_metodos_una_clase(ExpresionRegularClasesTest)
    metodos_assert = ExpresionRegularClasesTest.instance_methods(false).collect do
    |simbolo|
      ExpresionRegularClasesTest.instance_method(simbolo)
    end

    assert metodos == metodos_assert
  end

  def test_jp_expresion_de_clases_no_trae_metodos_de_la_clase_otra_prueba
    metodos = @jpexpresion_metodo.traer_metodos_una_clase(OtraPrueba)
    assert metodos == []
  end


end