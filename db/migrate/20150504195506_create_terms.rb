class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :title
      t.references :project, index: true, foreign_key: true
      t.boolean :plural

      t.timestamps null: false
    end
  end
end
