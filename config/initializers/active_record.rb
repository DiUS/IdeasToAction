# ColumnValues

# 20130604
# 0.0.0

module ActiveRecord
  module ColumnValues

    def method_missing(method_name, *args, &block)
      if column_names.collect{|e| e.pluralize}.include?(method_name.to_s)
        all.collect{|e| e.send(method_name.to_s.singularize)}
      else
        super(method_name, *args, &block)
      end
    end

  end
end

ActiveRecord::Base.extend(ActiveRecord::ColumnValues)
