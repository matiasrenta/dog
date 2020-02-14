
class LeyFraccionImport < BaseImport
  def create_entity_from_row(row)
    ley_fraccion = LeyFraccion.new
    ley_fraccion.codigo = row[I18n.translate('simple_form.labels.defaults.codigo')]
    ley_fraccion.name = row[I18n.translate('simple_form.labels.defaults.name')]
    ley_fraccion.descripcion_de_documento = row[I18n.translate('simple_form.labels.defaults.descripcion_de_documento')]
    ley_fraccion.periodo_actualizacion = row[I18n.translate('simple_form.labels.defaults.periodo_actualizacion')]
    ley_fraccion.detalle = row[I18n.translate('simple_form.labels.defaults.detalle')]
    ley_fraccion.ley_articulo_id = LeyArticulo.find_by_codigo(ley_fraccion.codigo[0..1]).id
    ley_fraccion
  end
end
