class Transaction < ApplicationRecord
  belongs_to :invoice
  validates_presence_of :result, :credit_card_number

  enum result: ["success", "failed"] # success = 0 failed = 1 but result in table is stored as a string so we need to convert to intgether (remigrate the tables)

end