class CreateFincas < ActiveRecord::Migration
  def change
    create_table :fincas do |t|
      t.string :nombre_finca
      t.string :localizacion
      t.string :clima
      t.integer :capacidad
      t.string :informacion
      t.float :lat
      t.float :lon
      t.integer :precio
      t.integer :idowner
      t.string :owner

      t.timestamps null: false
    end
  end
end
