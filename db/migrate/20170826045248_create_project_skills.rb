class CreateProjectSkills < ActiveRecord::Migration[5.1]
  def change
    create_table :project_skills do |t|
      t.references :projcect, foreign_key: true, index: true
      t.references :skill, foreign_key: true, index: true

      t.timestamps
    end
  end
end
