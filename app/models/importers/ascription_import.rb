
class AscriptionImport < BaseImport
  def create_entity_from_row(row)
    ascription = Ascription.new
    ascription.name = row[I18n.translate('simple_form.labels.defaults.name')]
    ascription
  end
end
