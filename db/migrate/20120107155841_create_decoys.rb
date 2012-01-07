class CreateDecoys < ActiveRecord::Migration
  def change
    create_table :decoys do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
