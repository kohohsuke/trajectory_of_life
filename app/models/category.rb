class Category < ActiveHash::belongs_to_active_hash
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '自社開発' },
    { id: 3, name: '受託開発' },
    { id: 4, name: 'SES' },
  ]

  include ActiveHash::Associations
  has_many :companies

end