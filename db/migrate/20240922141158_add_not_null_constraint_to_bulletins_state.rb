class AddNotNullConstraintToBulletinsState < ActiveRecord::Migration[7.1]
  def change
    if Bulletin.any?
      Bulletin.where(state: nil).update_all(state: 'draft')
    end

    change_column(:bulletins, :state, :string, default: 'draft', null: false)
  end
end
