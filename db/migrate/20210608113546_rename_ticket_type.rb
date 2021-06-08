class RenameTicketType < ActiveRecord::Migration[6.1]
  def change
    rename_column :tickets, :type, :ticket_type
  end
end
