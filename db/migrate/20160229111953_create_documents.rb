class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :user_id
      t.timestamps null: false
    end

    add_index :documents, :user_id
    add_attachment :documents, :file
    add_column :statuses, :document_id, :integer
  end
end
