class CreateExchangeableCurrencies < ActiveRecord::Migration[5.2]
  def change
    create_table :exchangeable_currencies do |t|
      t.string :from
      t.string :to
      t.timestamps
    end
    add_index :exchangeable_currencies, :from
  end
end
