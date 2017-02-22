Hanami::Model.migration do
  change do
    create_table :edges do
      primary_key :id

      column :length,      Integer
      column :source,      String
      column :destination, String
    end
  end
end
