class Address < ApplicationRecord
    belongs_to :customer
    belongs_to :order
    
    def postal_code_address_name
    self.postal_code + self.address + self.name
    end

end
