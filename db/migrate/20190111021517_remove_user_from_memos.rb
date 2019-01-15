class RemoveUserFromMemos < ActiveRecord::Migration[5.2]
  def change
    remove_reference :memos, :user, foreign_key: true
  end
end
