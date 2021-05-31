class Company < ApplicationRecord

  belongs_to :user

  with_options presence :true do
    validates :name
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :address
    validates :website
    validates :category_id
    validates :occupation_id
    validates :characteristic
    validates :first_reason
    validates :second_reason
    validates :third_reason
  end

end