
class LeyArticuloImport < BaseImport
  def create_entity_from_row(row)
    ley_articulo = LeyArticulo.new
    ley_articulo.codigo = row[I18n.translate('simple_form.labels.defaults.codigo')]
    ley_articulo.name = row[I18n.translate('simple_form.labels.defaults.name')]
    ley_articulo.descripcion_de_documento = row[I18n.translate('simple_form.labels.defaults.descripcion_de_documento')]
    ley_articulo.periodo_actualizacion = row[I18n.translate('simple_form.labels.defaults.periodo_actualizacion')]
    ley_articulo.detalle = row[I18n.translate('simple_form.labels.defaults.detalle')]
    ley_articulo
  end
end
