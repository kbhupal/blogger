class AddPhoneToUser < ActiveRecord::Migration
  def change
    add_column :users, :u_phone, :string
  end
end
