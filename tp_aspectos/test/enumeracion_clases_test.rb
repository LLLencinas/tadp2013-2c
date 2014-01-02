require 'test/unit'
require_relative '../test/clases_para_probar/clase_prueba'
require_relative '../test/clases_para_probar/otra_prueba'
require_relative '../src/join_point_clases_enumeracion'

class EnumeracionClasesTest < Test::Unit::TestCase


  def setup
    @clases_sistema = [EnumeracionClasesTest, ClasePrueba]
    @jpenum = JoinPointClasesEnumeracion.new(@clases_sistema)
  end

  def test_jp_enumeracion_de_clases_encuentra_clase
    clase_interesante = @jpenum.evaluar(ClasePrueba)
    assert clase_interesante
  end

  def test_jp_enumeracion_de_clases_no_encuentra_clase
    clase_interesante = @jpenum.evaluar(Class)
    assert !clase_interesante
  end

  def test_jp_enumeracion_de_clases_trae_metodos_de_la_clase_enumeracion_clases_test
    metodos = @jpenum.traer_metodos_una_clase(EnumeracionClasesTest)
    metodos_assert = EnumeracionClasesTest.instance_methods(false).collect do
    |simbolo|
      EnumeracionClasesTest.instance_method(simbolo)
    end

    assert metodos == metodos_assert
  end

  def test_jp_enumeracion_de_clases_no_trae_metodos_de_la_clase_otra_prueba
    metodos = @jpenum.traer_metodos_una_clase(OtraPrueba)
    assert metodos == []
  end





end