class AddStringsToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :client_name, :string
    add_column :articles, :email, :string
    add_column :articles, :phone, :string
    add_column :articles, :travellers, :string
  end
end
