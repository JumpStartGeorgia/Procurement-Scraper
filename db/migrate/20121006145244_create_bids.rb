class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :bidder_id
      t.date :bid_date
      t.decimal :value

      t.timestamps
    end
    
    add_index :bids, [:bidder_id, :bid_date, :value], :name => 'index_bids_values'
  end
end
