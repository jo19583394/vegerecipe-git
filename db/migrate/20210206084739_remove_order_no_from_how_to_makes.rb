class RemoveOrderNoFromHowToMakes < ActiveRecord::Migration[5.2]
  def change
    remove_column :how_to_makes, :order_no, :integer
  end
end
