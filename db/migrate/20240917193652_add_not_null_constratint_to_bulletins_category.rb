class AddNotNullConstratintToBulletinsCategory < ActiveRecord::Migration[7.2]
  def change
    Bulletin.where(category_id: nil).update_all(category_id: Category.first.id)
    change_column_null(:bulletins, :category_id, false)
  end
end
