class Occupation < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: 'ネットワークエンジニア' },
    { id: 2, name: 'サーバーサイドエンジニア' },
    { id: 3, name: 'フロントサイドエンジニア' },
    { id: 4, name: 'データベースエンジニア' },
    { id: 5, name: 'セキュリティエンジニア' },
    { id: 6, name: 'クラウドエンジニア' },
    { id: 7, name: 'テストエンジニア' },
  ]

  include ActiveHash::Associations
  has_many :companies

end