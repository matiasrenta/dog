class ThingImport < BaseImport
  def create_entity_from_row(row)
    thing = Thing.new
    thing.name = row[I18n.translate('simple_form.labels.defaults.name')]
    thing.age = row[I18n.translate('simple_form.labels.defaults.age')]
    thing.price = row[I18n.translate('simple_form.labels.defaults.price')]
    thing.expires = row[I18n.translate('simple_form.labels.defaults.expires')]
    thing.discharged_at = row[I18n.translate('simple_form.labels.defaults.discharged_at')]
    thing.description = row[I18n.translate('simple_form.labels.defaults.description')]
    thing.published = row[I18n.translate('simple_form.labels.defaults.published')]
    thing.gender = row[I18n.translate('simple_form.labels.defaults.gender')]
    thing.thing_category_id = row[I18n.translate('simple_form.labels.defaults.thing_category_id')]
    thing
  end
end

