class ModifyPostCommentsKey < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts,:parent_id
    add_column :posts,:post_id,:integer
  end
end
