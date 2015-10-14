class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.integer :finca_id
      t.string :username
    	t.string :nombre
    	t.integer :cedula
    	t.string :email
    	t.integer :telefono
    	t.integer :celular
    	t.string :password

      t.timestamps null: false
    end
  end
end
