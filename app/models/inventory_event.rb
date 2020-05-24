class InventoryEvent < ActiveRecord::Base
  belongs_to :box
  belongs_to :product

  EVENT_ADD = 'ADD'
  EVENT_REMOVE = 'REMOVE'
  EVENT_ADJUST = 'ADJUST'
  EVENT_CONVERT = 'CONVERT'
  EVENTS = [EVENT_ADD, EVENT_REMOVE, EVENT_ADJUST, EVENT_CONVERT]
  EVENTS_COLLECTION = [['ENTRADA', EVENT_ADD], ['SALIDA', EVENT_REMOVE], ['CONVERSIÓN', EVENT_CONVERT], ['AJUSTE', EVENT_ADJUST]]

  # ADD REASONS
  REASON_PURCHASE = 'PURCHASE'
  REASON_ORDER_DESTROY = 'ORDER_DESTROY'
  REASON_CUSTOMER_REJECT_SHIPPING = 'CUSTOMER_REJECT_SHIPPING'
  REASON_CUSTOMER_RETURN = 'CUSTOMER_RETURN'
  # REMOVE REASONS
  REASON_SALE = 'SALE'
  REASON_GIFT_TO_CUSTOMER = 'GIFT_TO_CUSTOMER'
  REASON_GIFT = 'GIFT'
  REASON_SUPPLIER_RETURN = 'SUPPLIER_RETURN'
  REASON_THROW_FOR_EXPIRATION = 'THROW_FOR_EXPIRATION'
  REASON_THROW = 'THROW'
  # CONVERT REASONS
  REASON_UBD ='UNIFORM_BOX_DISASSEMBLY'
  REASON_UBA = 'UNIFORM_BOX_ASSEMBLY'
  REASON_MBA = 'MIX_BOX_ASSEMBLY'
  # ADJUST REASONS
  REASON_SCHEDULED_ADJUST = 'SCHEDULED_ADJUST'
  REASON_OCCASIONAL_ADJUST = 'OCCASIONAL_ADJUST'
  # OTHER REASON
  REASON_OTHER = 'OTHER'

  ADD_REASONS = [REASON_PURCHASE, REASON_ORDER_DESTROY, REASON_CUSTOMER_REJECT_SHIPPING, REASON_CUSTOMER_RETURN, REASON_OTHER]
  REMOVE_REASONS = [REASON_SALE, REASON_GIFT_TO_CUSTOMER, REASON_GIFT, REASON_SUPPLIER_RETURN, REASON_THROW_FOR_EXPIRATION, REASON_THROW, REASON_OTHER]
  CONVERT_REASONS = [REASON_UBD, REASON_MBA, REASON_UBA, REASON_OTHER]
  ADJUST_REASONS = [REASON_SCHEDULED_ADJUST, REASON_OCCASIONAL_ADJUST, REASON_OTHER]
  REASONS = (ADD_REASONS + REMOVE_REASONS + ADJUST_REASONS + CONVERT_REASONS).uniq

  ADD_REASONS_COLLECTION = [['COMPRA', REASON_PURCHASE], ['EL CLIENTE RECHAZÓ EL ENVÍO', REASON_CUSTOMER_REJECT_SHIPPING], ['DEVOLUCIÓN DE CLIENTE', REASON_CUSTOMER_RETURN], ['OTRA', REASON_OTHER]]
  REMOVE_REASONS_COLLECTION = [['REGALO A CLIENTE', REASON_GIFT_TO_CUSTOMER], ['REGALO', REASON_GIFT],
                    ['DEVOLUCIÓN A PROVEEDOR', REASON_SUPPLIER_RETURN], ['TIRAR POR CADUCIDAD', REASON_THROW_FOR_EXPIRATION],
                    ['TIRAR', REASON_THROW], ['OTRA', REASON_OTHER]]
  CONVERT_REASONS_COLLECTION = [['ARMADO CAJA SURTIDA', REASON_MBA], ['ARMADO CAJA UNIFORME', REASON_UBA], ['DESARMADO CAJA UNIFORME', REASON_UBD]]
  ADJUST_REASONS_COLLECTION = [['AJUSTE PROGRAMADO', REASON_SCHEDULED_ADJUST], ['AJUSTE OCACIONAL', REASON_OCCASIONAL_ADJUST], ['OTRA', REASON_OTHER]]
  REASONS_COLLECTION = (ADD_REASONS_COLLECTION + REMOVE_REASONS_COLLECTION + CONVERT_REASONS_COLLECTION + ADJUST_REASONS_COLLECTION).uniq




  validates :event, :reason, :product_id, :quantity, :box_id, presence: true
  validates :quantity, :product_id, :box_id, numericality: true

  before_create do
    Inventory.update_stock({product_id: self.product_id,
                                box_id: self.box_id,
                              quantity: self.quantity,
                                 event: self.event,
                                reason: self.reason,
                       expiration_date: self.expiration_date} )
  end


end
