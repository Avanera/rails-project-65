class DeleteUniqueIndexOnUsersName < ActiveRecord::Migration[7.2]
  def change
    remove_index :users, :name
  end
end
