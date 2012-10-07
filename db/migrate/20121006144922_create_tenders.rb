class CreateTenders < ActiveRecord::Migration
  def change
    create_table :tenders do |t|
      t.string :url_id
      t.integer :procurring_entity_id
      t.string :tender_type
      t.string :tender_registration_number
      t.string :tender_status
      t.date :tender_announcement_date
      t.date :bid_start_date
      t.date :bid_end_date
      t.decimal :estimated_value, :precision => 11, :scale => 2
      t.boolean :include_vat
      t.string :cpv_code
      t.integer :winning_bid_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
    
    
    add_index :tenders, :procurring_entity_id
    add_index :tenders, :procurring_entity_id
    add_index :tenders, :tender_type
    add_index :tenders, :tender_status
    add_index :tenders, :estimated_value
    add_index :tenders, :winning_bid_id
  end
end
