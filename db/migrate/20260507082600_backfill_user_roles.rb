class BackfillUserRoles < ActiveRecord::Migration[8.1]
  def up
    execute <<~SQL
      UPDATE users
      SET role = 1
      WHERE role IS NULL OR role = 0
    SQL
  end

  def down
    execute <<~SQL
      UPDATE users
      SET role = 0
      WHERE role = 1
    SQL
  end
end
