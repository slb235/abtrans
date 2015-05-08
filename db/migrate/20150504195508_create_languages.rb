class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :title
      t.string :locale
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
