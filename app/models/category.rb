class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '自社開発' },
    { id: 2, name: '受託開発' },
    { id: 3, name: 'SES' },
  ]

  include ActiveHash::Associations
  has_many :companies

end