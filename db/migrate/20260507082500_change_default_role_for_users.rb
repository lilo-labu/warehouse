class ChangeDefaultRoleForUsers < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :role, from: 0, to: 1
  end
end
