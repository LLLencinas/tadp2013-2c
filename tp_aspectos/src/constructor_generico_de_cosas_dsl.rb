
module Constructor_Dsl


  def construir &bloque_configuracion
    construccion_temporal=self.tu_clase_a_buildear.new
    construccion_temporal.instance_eval &bloque_configuracion
    construccion_temporal.crear_construccion
  end

end