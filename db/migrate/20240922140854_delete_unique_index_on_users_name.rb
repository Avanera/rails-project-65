class DeleteUniqueIndexOnUsersName < ActiveRecord::Migration[7.1]
  def change
    remove_index :users, :name
  end
end
