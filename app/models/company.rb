class Company < ApplicationRecord

  belongs_to :user

  with_options presence: true do
    validates :name
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'にはハイフン"-"を含めてください' }
    validates :address
    validates :website
    validates :characteristic
    validates :first_reason
    validates :second_reason
    validates :third_reason
    
    with_options numericality: { other_than: 1, message: 'を選択してください' } do
      validates :category_id
      validates :occupation_id
    end

  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :occupation
  belongs_to_active_hash :category

end