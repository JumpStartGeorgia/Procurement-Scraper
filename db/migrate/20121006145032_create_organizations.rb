class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :url_id
      t.string :label_id
      t.string :name
      t.string :country

      t.timestamps
    end

    add_index :organizations, [:url_id, :name]
    add_index :organizations, [:label_id, :name]
  end
end
