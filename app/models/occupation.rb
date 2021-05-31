class Occupation < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'ネットワークエンジニア' },
    { id: 3, name: 'サーバーサイドエンジニア' },
    { id: 4, name: 'フロントサイドエンジニア' },
    { id: 5, name: 'データベースエンジニア' },
    { id: 6, name: 'セキュリティエンジニア' },
    { id: 7, name: 'クラウドエンジニア' },
    { id: 8, name: 'テストエンジニア' },
  ]

  include ActiveHash::Associations
  has_many :companies

end