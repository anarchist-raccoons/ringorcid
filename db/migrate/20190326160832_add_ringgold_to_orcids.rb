class AddRinggoldToOrcids < ActiveRecord::Migration[5.2]
  def change
    add_column :orcids, :ringgold, :string
  end
end
