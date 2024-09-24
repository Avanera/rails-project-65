class AddStateToBulletins < ActiveRecord::Migration[7.1]
  def change
    add_column :bulletins, :state, :string, default: 'draft', null: false
  end
end
