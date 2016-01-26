class CreateBucketlists < ActiveRecord::Migration[5.0]
  def change
    create_table :bucketlists do |t|
      t.string :name
      t.string :created_by

      t.timestamps
    end
    add_index :bucketlists, :created_by
  end
end
