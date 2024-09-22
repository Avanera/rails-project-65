class AddNotNullConstratintToBulletinsCategory < ActiveRecord::Migration[7.1]
  def change
    if Bulletin.any? && Category.any?
      Bulletin.where(category_id: nil).update_all(category_id: Category.first.id)
    end

    change_column_null(:bulletins, :category_id, false)
  end
end
