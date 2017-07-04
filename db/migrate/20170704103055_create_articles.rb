class CreateArticles < ActiveRecord::Migration
  def up
    create_table :articles do |t|
      t.string :title
    end
  end
end
