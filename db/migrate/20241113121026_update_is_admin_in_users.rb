class UpdateIsAdminInUsers < ActiveRecord::Migration[7.2]
  def change
    User.where(is_admin: nil).update_all(is_admin: false)
    change_column_default :users, :is_admin, from: nil, to: false
    change_column_null :users, :is_admin, false
  end
end