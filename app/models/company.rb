class Company < ApplicationRecord

  belongs_to :user
  has_many :comments

  with_options presence: true do
    validates :name
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'にはハイフン"-"を含めてください' }
    validates :address
    validates :website
    validates :characteristic
    validates :first_reason
    validates :second_reason
    validates :third_reason
    
    with_options numericality: { other_than: 0, message: 'を選択してください' } do
      validates :category_id
      validates :occupation_id
    end

  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :occupation
  belongs_to_active_hash :category

  class << self

    def category_data_acquisition_for_graphs
      categories = all
      category_graph_data = {}
      categories.each_with_index do |data, index|
        category_graph_data = { data.category.name => 1} if index.zero?
        if category_graph_data.key?(data.category.name)
          category_graph_data[data.category.name] += 1
        else
          category_graph_data[data.category.name] = 1
        end
      end
      category_graph_data
    end
  end
end