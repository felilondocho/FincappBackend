class CreateLeasings < ActiveRecord::Migration
  def change
    create_table :leasings do |t|
    	t.integer :finca_id
    	t.string :datetime
    	t.string :estado
    	t.integer :user_id
    	t.boolean :calificacion

    	t.timestamps null: false
    end
  end
end
