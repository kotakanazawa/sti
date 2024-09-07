class AddAttributesToAnimals < ActiveRecord::Migration[7.2]
  def change
    add_column :animals, :bark_volume, :integer
    add_column :animals, :claw_sharpness, :integer
  end
end
