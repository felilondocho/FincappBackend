class ChangeTelefonoTousers < ActiveRecord::Migration
  def change
  	change_column :users, :telefono, :bigint
  	change_column :users, :celular, :bigint
  end
end
