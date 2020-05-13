class InventoryEvent < ActiveRecord::Base
  belongs_to :box
  belongs_to :product
  #belongs_to :inventory

#  EVENTS = [['ENTRADA', 'ADD'], ['SALIDA', 'REMOVE'], ['AJUSTE', 'ADJUST'], ['CONVERSIÓN', 'CONVERT']]
#
#  REASONS = [['COMPRA', 'PURCHASE'], ['DEVOLUCIÓN DE CLIENTE', 'CUSTOMER_RETURN'],
#             ['VENTA', 'SALE'], ['REGALO A CLIENTE', 'GIFT_TO_CUSTOMER'], ['REGALO', 'GIFT'],
#             ['DEVOLUCIÓN A PROVEEDOR', 'SUPPLIER_RETURN'], ['TIRAR POR CADUCIDAD', 'THROW_FOR_EXPIRATION'],
#             ['TIRAR', 'THROW'], ['AJUSTE PROGRAMADO', 'SCHEDULED_ADJUST'], ['AJUSTE OCACIONAL', 'OCCASIONAL_ADJUST'],
#             ['ARMADO CAJA SURTIDA', 'MIX_BOX_ASSEMBLY'], ['ARMADO CAJA UNIFORME', 'UNIFORM_BOX_ASSEMBLY'], ['OTRA', 'OTHER']]
#
#  ADD_REASONS = [['COMPRA', 'PURCHASE'], ['DEVOLUCIÓN DE CLIENTE', 'CUSTOMER_RETURN'], ['OTRA', 'OTHER']]
#
#  REMOVE_REASONS = [['VENTA', 'SALE'], ['REGALO A CLIENTE', 'GIFT_TO_CUSTOMER'], ['REGALO', 'GIFT'],
#                    ['DEVOLUCIÓN A PROVEEDOR', 'SUPPLIER_RETURN'], ['TIRAR POR CADUCIDAD', 'THROW_FOR_EXPIRATION'],
#                    ['TIRAR', 'THROW'], ['OTRA', 'OTHER']]
#
#  ADJUST_REASONS = [['AJUSTE PROGRAMADO', 'SCHEDULED_ADJUST'], ['AJUSTE OCACIONAL', 'OCCASIONAL_ADJUST'], ['OTRA', 'OTHER']]
#
#  CONVERSION_REASONS = [['ARMADO CAJA SURTIDA', 'MIX_BOX_ASSEMBLY'], ['ARMADO CAJA UNIFORME', 'UNIFORM_BOX_ASSEMBLY']]


  EVENT_ADD = 'ADD'
  EVENT_REMOVE = 'REMOVE'
  EVENT_ADJUST = 'ADJUST'
  EVENT_CONVERT = 'CONVERT'

  EVENTS = [EVENT_ADD, EVENT_REMOVE, EVENT_ADJUST, EVENT_CONVERT]

  REASON_SALE = 'SALE'
  REASON_UBD ='UNIFORM_BOX_DISASSEMBLY'
  REASON_UBA = 'UNIFORM_BOX_ASSEMBLY'


  ADD_REASONS = ['PURCHASE', 'CUSTOMER_REJECT_SHIPPING', 'CUSTOMER_RETURN', 'OTHER']

  REMOVE_REASONS = ['SALE', 'GIFT_TO_CUSTOMER', 'GIFT', 'SUPPLIER_RETURN', 'THROW_FOR_EXPIRATION', 'THROW', 'OTHER']

  ADJUST_REASONS = ['SCHEDULED_ADJUST', 'OCCASIONAL_ADJUST', 'OTHER']

  CONVERT_REASONS = [REASON_UBD, 'MIX_BOX_ASSEMBLY', REASON_UBA, 'OTHER']

  ALL_REASONS = (ADD_REASONS + REMOVE_REASONS + ADJUST_REASONS + CONVERT_REASONS).uniq


  validates :event, :reason, :quantity, :box_id, presence: true
  validates :quantity, :box_id, numericality: true

  before_create :update_inventory


  def self.handle_event_creation(data)
    # si data viene con fecha de vencimiento, entonce buscamos ese produto, con esa caja y esa fecha
    # sino, buscamos producto, caja, y la primer fecha de vencimiento (que no esté en promoción, por ahora asi nomás)
    # si no alcanza la cantidad se crea oto evento con la proxima fecha de vto y asi hasta alcanzar la cantidad necesitada



  end

  private

  def update_inventory

  end

  def add_to_inventory
    @inventory.quantity_available = @inventory.quantity_available + self.quantity
  end

  def remove_from_inventory
    if @inventory.quantity_available < self.quantity
      errors.add(:quantity, 'No hay stock suficiente')
      false
    else
      @inventory.quantity_available = @inventory.quantity_available - self.quantity
    end
  end

  def adjust_inventory
    # aca el tema es que se contaron por ejemplo 10 cajas en el deposito al hacer el inventario fisico. y el sistema dice que hay 11.
    # lo que pasa es que hay una que está pedida por un cliente y por eso se descontó. Lo que se puede hacer es:
    # si quantity.available + la suma de todos los pedidos con este producto (caja y fecha vto.) es igual a quantity. entonces no se hace nada
    # si es menor entonces se suma la diferencia a quantity_available, si es mayor entonces se le resta a quantity.available

    diferencia = @inventory.quantity_warehouse - self.quantity_count_by_human # (ejmplo: -1 = 10 - 11)

    # diferencia < 0 => SOBRANTE: hay más en el deposito que lo que dice el sistema
    # diferencia > 0 => FALTANTE: hay menos en el deposito que lo que dice el sistema
    # diferencia = 0 => JOYA!
    # es mejor un sobrante que un faltante pero ambos son negativos.

    @inventory.quantity_available = @inventory.quantity_available + diferencia

    #if diferencia < 0 # (SOBRANTE)
    #  @inventory.quantity_available = @inventory.quantity_available + diferencia
    #elsif diferencia > 0 # (FALTANTE)
    #  @inventory.quantity_available = @inventory.quantity_available + diferencia
    #end

    return false if diferencia == 0 # si no hay faltante no sobrante no se debe crear ningun InventoryEvent record. solo se crean cuando hay diferencia
  end


  def convert_inventory
    if @inventory.quantity_available < self.quantity
      errors.add(:quantity, 'No hay stock suficiente')
      false
    else
      @inventory.quantity_available = @inventory.quantity_available - self.quantity
      # ahora debo crear o updetear el registro para hacer el add de las unidades
      @inventory_to_add = Inventory.where(product_id: self.poroduct_id, expiration_date: self.expiration_date, box_id: Box.units_box.id).first_or_initialize
      @inventory_to_add.quantity_available = 0 if @inventory_to_add.new_record?
      @inventory_to_add.quantity_available = @inventory_to_add.quantity_available + self.quantity
      @inventory_to_add.save
    end
  end

end
