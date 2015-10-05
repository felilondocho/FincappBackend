class Finca < ActiveRecord::Base
	has_many :images, :dependent => :destroy
	has_one :rating
	accepts_nested_attributes_for :images,:rating
end
