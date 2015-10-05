class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|

    	t.integer :finca_id
		t.integer :votos1
		t.integer :votos2
		t.integer :votos3
		t.integer :votos4
		t.integer :votos5

      t.timestamps null: false
    end
  end
end
