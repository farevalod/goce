class Doctor < ActiveRecord::Base
has_many :groups
has_and_belongs_to_many :sessions
end
