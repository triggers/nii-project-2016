Sequel.migration do
  up do
    create_table(:comments) do
      primary_key :id, :type=>"int(11)"
      column :display_name, "varchar(255)", :null=>false
      column :description, "varchar(255)"
      column :comment, "text", :null=>false
      column :created_at, "datetime", :null=>false
      column :updated_at, "datetime", :null=>false
      index [:id], :unique=>true, :name=>:id
    end
  end

  down do
    drop_table(:comments)
  end
end
