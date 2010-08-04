require 'yaml'
require 'model/*'
table_config = YAML.load_file( File.join( '.', 'config', 'table.yml' ) )
Table.new(table_config)



