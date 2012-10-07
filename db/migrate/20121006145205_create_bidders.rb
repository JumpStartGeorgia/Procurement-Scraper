class CreateBidders < ActiveRecord::Migration
  def change
    create_table :bidders do |t|
      t.integer :tender_id
      t.integer :organization_id

      t.timestamps
    end
    
    add_index :bidders, [:tender_id, :organization_id]
  end
end
