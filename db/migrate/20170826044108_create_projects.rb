class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :title, null: false, default: ""
      t.text :detail, null: false, default: ""

      t.timestamps
    end
  end
end
