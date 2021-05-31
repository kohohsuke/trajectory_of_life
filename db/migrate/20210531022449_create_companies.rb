class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name,           null: false
      t.string :post_code,      null: false
      t.string :address,        null: false
      t.string :website,        null: false
      t.integer :category_id,   null: false
      t.integer :occupation_id, null: false
      t.text :characteristic,   null: false
      t.string :first_reason,   null: false
      t.string :second_reason,  null: false
      t.string :third_reason,   null: false
      t.references :user,       foreign_key: true
      t.timestamps
    end
  end
end