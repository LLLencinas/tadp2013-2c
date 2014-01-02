require 'test/unit'
require_relative 'clases_para_probar/aspecto_mock'
require_relative '../src/join_point_metodos_enumeracion'
require_relative 'clases_para_probar/clase_para_mock'

class AspectoMockAdviceDinamicoTest < Test::Unit::TestCase

  def setup
    point_cut = JoinPointMetodosEnumeracion.new(%w(metodo_clase_mock1 metodo_clase_mock2))
    @mock = AspectoMock.new(point_cut, nil)
    @mock.aplicar_dinamicamente
  end

  def test_se_puede_agregar_metodo_dinamicamente_y_afectarlo_porque_cumple_pc

    @mock.aplicar()
    ClaseParaMock.send(:define_method, :metodo_clase_mock2, Proc.new{} )
    assert (@mock.nombres_metodos_nuevos == [:metodo_clase_mock2])

  end

  def test_se_puede_agregar_metodo_dinamicamente_y_no_afectarlo_si_no_cumple_pc

    @mock.aplicar()
    ClaseParaMock.send(:define_method, :lalalala, Proc.new{} )
    assert(@mock.nombres_metodos_nuevos == [], "la coleccion es #{@mock.nombres_metodos_nuevos.each do |n| puts n end}")

  end

  def test_se_puede_agregar_metodos_con_parametros_y_siguen_haciendo_todo
    @mock.aplicar()
    proc_nuevo = Proc.new{|par1,par2| par1+par2}
    ClaseParaMock.send(:define_method, :metodo_clase_mock2, proc_nuevo)
    resultado = ClaseParaMock.new.metodo_clase_mock2(1,2)
    assert( @mock.nombres_metodos_nuevos.first == :metodo_clase_mock2)
    assert(resultado == 3)
  end

end