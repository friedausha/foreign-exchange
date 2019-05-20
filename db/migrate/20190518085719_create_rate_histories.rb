class CreateRateHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :rate_histories do |t|
      t.bigint :exchangeable_currency_id
      t.date :date
      t.float :rate
      t.timestamps
    end
    add_foreign_key :rate_histories, :exchangeable_currencies, on_delete: :cascade
    add_index :rate_histories, :date
    add_index :rate_histories, :exchangeable_currency_id
  end
end
