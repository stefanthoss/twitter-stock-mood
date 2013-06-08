class AddTimeZoneToStocks < ActiveRecord::Migration
  def change
    add_column :stocks, :time_zone, :string
  end
end
