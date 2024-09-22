class AddAdminToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin, :boolean, default: false, null: false

    User.where.not(email: 'arinaazai@gmail.com').update_all(admin: false)
    User.where(email: 'arinaazai@gmail.com').update_all(admin: true)
  end
end
