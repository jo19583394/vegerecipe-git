class ChangeDatatypeProcessImageOfHowToMakes < ActiveRecord::Migration[5.2]
  def change
    change_column :how_to_makes, :process_image, :binary
  end
end
