class AddDescriptionToDuties < ActiveRecord::Migration[6.0]
  def change
    add_column :duties, :description, :text
  end
end
