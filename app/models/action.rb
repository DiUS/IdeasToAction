class Action < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  index_name { "#{Rails.env}-#{table_name}" }
  
  tire.instance_eval do
    # This is a work-around to allow setting the mapping without the indexes actually being created by Tire

    @mapping ||= {}

    indexes :id,              :index    => :not_analyzed
    indexes :idea_id,         :index    => :not_analyzed
    indexes :created_at,      :type => 'date', :include_in_all => false
    indexes :updated_at,      :type => 'date', :include_in_all => false
    indexes :description,     :boost => 100
  end  
      
  attr_accessible :description, :featured

  belongs_to :idea

  has_many :actions_taken do
    def from_member member
      find(:first, :conditions => ['member_id = ?', member.id])
    end
  end

  def as_json options = nil
    super.merge(members_actioned_count: members_actioned.size)
  end

  private
  def members_actioned
    Idea.find_by_sql("select distinct at.member_id from " + 
                      "actions a, actions_taken at where " +
                      "at.action_id = a.id and a.id = #{self.id}")
  end
end
