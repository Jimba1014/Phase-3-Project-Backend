class Author < ActiveRecord::Base
    has_many :articles
    has_many :categories, through: :articles

    def full_name
        "#{self.first_name} #{self.last_name}"
    end
end