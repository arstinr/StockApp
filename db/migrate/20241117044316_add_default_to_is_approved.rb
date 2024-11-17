class AddDefaultToIsApproved < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :is_approved, from: nil, to: false
  end
end
