class RenameAasmStateToStateInBulletins < ActiveRecord::Migration[7.1]
  def change
    rename_column :bulletins, :aasm_state, :state
  end
end
