class Order < ApplicationRecord
    has_many :order_items
    belongs_to :customer
    has_many :addresses
    
    OrderItem.all.sum(:price)
    enum sales_order_status:{入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}
end
