class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :title
      t.string :title_plural
      t.references :language, index: true, foreign_key: true
      t.references :term, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
