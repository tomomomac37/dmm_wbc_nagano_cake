class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cart_items
  has_many :addresses
  has_many :orders
  
  enum is_active: { '有効': true, '退会済': false }
  
  def active_for_authentication?
    super && self.is_active == '有効'
  end
end
