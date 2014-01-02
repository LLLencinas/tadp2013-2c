require_relative '../src/join_point'
class JoinPointClases < JoinPoint
  def traer_metodos_una_clase(una_clase)
    if(self.evaluar(una_clase))
    then
      super
    else
      []

    end
  end
end