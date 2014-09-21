class CreateResumes < ActiveRecord::Migration
  def up
    create_table :resumes do |t|
      t.string    :title
      t.string    :body
    end
  end

  def down
    drop_table    :resumes
  end
end
