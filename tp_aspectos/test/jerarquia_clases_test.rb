require_relative '../test/clases_para_probar/clase_padre'
require_relative '../../tp_aspectos/src/join_point_clases_jerarquia'
require_relative '../../tp_aspectos/src/join_point_clases_enumeracion'
require 'test/unit'
class JerarquiaClasesTest < Test::Unit::TestCase
  def setup
    @clases_sistema = [ClaseHijo,ClasePadre]
    @jpjerarquia_hijo = JoinPointClasesJerarquia.new(ClaseHijo)
    @jpjerarquia_padre = JoinPointClasesJerarquia.new(ClasePadre)
  end

  def test_jp_jerarquia_hijo_trae_metodos_de_clase_hijo_porque_se_encuentra_a_si_misma_en_su_jerarquia
    metodos = @jpjerarquia_hijo.traer_metodos_una_clase(ClaseHijo)
    metodos_clase_hijo = ClaseHijo.instance_methods(false).collect do |simbolo| ClaseHijo.instance_method(simbolo) end

    assert metodos ==  metodos_clase_hijo
  end
  def test_jp_jerarquia_padre_trae_metodos_de_clase_hijo_porque_la_encuentra_en_su_jerarquia
    metodos = @jpjerarquia_padre.traer_metodos_una_clase(ClaseHijo)
    metodos_clase_hijo = ClaseHijo.instance_methods.collect do |simbolo| ClaseHijo.instance_method(simbolo) end
    assert metodos = metodos_clase_hijo
  end
  def test_jp_jerarquia_no_encuentra_metodos
    jpjerarquia = JoinPointClasesJerarquia.new(Numeric)
    resultado = jpjerarquia.traer_metodos_col_clases(@clases_sistema)
    assert resultado == []
  end
end