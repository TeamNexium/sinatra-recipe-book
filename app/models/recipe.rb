class Recipe < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :name, :ingredients, :instructions
end