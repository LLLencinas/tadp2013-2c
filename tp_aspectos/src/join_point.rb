class JoinPoint
  def traer_metodos_una_clase(una_clase)
    una_clase.instance_methods(false).collect do
        |un_metodo| una_clase.instance_method(un_metodo)
      end
  end
  def traer_metodos_col_clases(col_clases)
    col_metodos = []
    col_clases.each {
      |una_clase| col_metodos.concat(self.traer_metodos_una_clase(una_clase))
    }
    col_metodos.uniq
  end

end