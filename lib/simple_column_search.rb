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
module SimpleColumnSearch
  def self.included(base)
    base.send :named_scope, :search, lambda { |terms|
      conditions = terms.split.inject(nil) do |acc, term|
        pattern = term + '%'
        base.send(:merge_conditions, acc, [base::SIMPLE_COLUMN_SEARCH.collect { |column| "#{base.table_name}.#{column} LIKE :pattern" }.join(' OR '), { :pattern => pattern }])
      end
    
      { :conditions => conditions }
    }
  end
end