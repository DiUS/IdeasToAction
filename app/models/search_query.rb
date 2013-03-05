class SearchQuery
  extend ActiveModel::Naming
  extend ActiveModel::Translation
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::MassAssignmentSecurity

  attr_accessible :text

  attr_accessor :text

  validates_presence_of :text

  def initialize(values, options = {})
    assign_attributes(values, options)
  end

  def assign_attributes(values, options = {})
    sanitize_for_mass_assignment(values, options[:as]).each do |k, v|
      send("#{k}=", v)
    end
  end  
end