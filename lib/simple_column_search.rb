require 'rubygems'
require 'activerecord'

# Adds a Model.search('term1 term2') method that searches across SEARCH_COLUMNS
# for OR'd terms using the LIKE operator with a pattern of "term1%".
#
# Usage:
#   
#   class User
#     SEARCHABLE_COLUMNS = %w(login first_name last_name)
#     include SearchColumns
#   end
#  
#   User.search('Firsty')
#   User.search('Firsty Lasty')

class ActiveRecord::Base
  def self.simple_column_search(*columns)
    named_scope :search, lambda { |terms|
      conditions = terms.split.inject(nil) do |acc, term|
        pattern = term + '%'
        merge_conditions  acc, [columns.collect { |column| "#{table_name}.#{column} LIKE :pattern" }.join(' OR '), { :pattern => pattern }]
      end
    
      { :conditions => conditions }
    }
  end
  
end
