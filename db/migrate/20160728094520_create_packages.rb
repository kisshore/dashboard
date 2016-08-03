class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.text :component
      t.text :version

      t.timestamps null: false
    end
  end
end
