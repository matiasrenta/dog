class BaseImport
  include ActiveModel::Model
  attr_accessor :file, :quantity_records, :save_in_ddbb
  def initialize(attributes = {})
    attributes.each { |name, value| send("#{name}=", value) }
  end

  def persisted?
    false
  end

  # esto sirvió para actulizar las arear de key_analiticals desde el excel
  #def save
  #  if save_in_ddbb == '1'
  #    KeyAnalytical.all.order(:id).each_with_index do |ka, i|
  #      ka.update!(cat_are_area_id: imported_entities[i].cat_are_area_id)
  #    end
  #  end
  #  true
  #end

  def save
    if imported_entities.map(&:valid?).all?
      if save_in_ddbb == '1'
        model = self.class.name # ejemplo: ThingImport
        model.slice! "Import" # quito el Import para que quede Thing
        PaperTrail.enabled = false
        eval("#{model}.import imported_entities")  # esto es del gem activerecord-import el cual hace una sola sentencia insert para todos los registros. Cuidado: no validations y no callbacks
        PaperTrail.enabled = true
      end
      true
    else
      errors.add(:base, I18n.translate('activerecord.errors.messages.invalid_imported_entities'))
      #imported_entities.each_with_index do |entity, index|
      #  entity.errors.full_messages.each do |message|
      #    errors.add :base, "Fila #{index+2}: #{message}"
      #  end
      #end
      c = []
      imported_entities.each_with_index do |entity, index|
        if entity.errors.any?
          c << index + 1
          if c.size < 10
            errors.add :base, "Fila #{index+2}: #{entity.errors.full_messages}"
          end
        end
      end
      errors.add :base, "cantidad de filas con errores: #{c.size}"
      false
    end
  end

  def imported_entities
    @imported_entities ||= load_imported_entities
  end

  def load_imported_entities
    entities = Array.new
    spreadsheet = open_spreadsheet
    header_aux = spreadsheet.row(1)
    header = Array.new
    header_aux.each {|e| header << e.strip}

    secuencia = 2..spreadsheet.last_row if quantity_records == 'todos'
    secuencia = 2..3 if quantity_records == 'un_par'

    (secuencia).map do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      entities << create_entity_from_row(row)
    end
    entities
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
      when ".xlsx" then Roo::Spreadsheet.open(file.path, extension: :xlsx)
      when ".xls" then Roo::Spreadsheet.open(file.path, extension: :xls)
      else raise "Tipo de archivo desconocido: #{file.original_filename}. (tipos aceptados: .xls, .xlsx)"
    end
  end
end