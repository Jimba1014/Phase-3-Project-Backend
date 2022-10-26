class Article < ActiveRecord::Base
    has_many :pictures
    belongs_to :author
    belongs_to :category

end