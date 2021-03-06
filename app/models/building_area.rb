class BuildingArea < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 200
  has_many :freezers
  acts_as_audited :except => [:created_at, :updated_at]
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  default_scope :order => :name
  
  scope :for_search_query, lambda { |search_terms| { :conditions => [ 'name IN (?)', search_terms ] } }
 
  def assets
    Asset.joins( :storage_area => { :freezer => :building_area } ).where( :building_areas => { :id => self.id } )
  end
  
end
