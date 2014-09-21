class CreateSkills < ActiveRecord::Migration
  def up
    create_table :skills do |t|
      t.string    :name
    end
  end

  def down
    drop_tables :skills
  end
end
