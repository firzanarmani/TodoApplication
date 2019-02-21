class Tag < ApplicationRecord
    validates_uniqueness_of :name, scope: [:user_id]
    has_many :taggings
    has_many :todos, through: :taggings
    belongs_to :user
end
