class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :name
      t.text :body
      t.boolean :ativo

      t.timestamps
    end
  end
end
