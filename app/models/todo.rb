class Todo < ApplicationRecord
    # Validation for todo item; must not be empty
    validates :item, presence: true

    # By recommendation of https://github.com/rubocop-hq/rails-style-guide#activerecord use has_many :through instead of 
    # has_and_belongs_to_many, because has_many :through "allows additional attributes and validations on the join model"
    # Hence, decided to use this for future-proofing, should the need arise.
    has_many :taggings
    has_many :tags, through: :taggings
    belongs_to :user

    def self.tagged_with(id)
        Tag.find_by!(id: id).todos
        # find_by!(arg, *args) - Finds the first record matching the specified conditions.
        #                        No implied ordering. If no record found, raises an ActiveRecord::RecordNotFound error
    end

    def self.tag_counts
        Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
        # select(*fields)
    end

    def tag_list
        tags.map(&:name).join(', ')
    end

    def tag_list=(names)
        self.tags = names.split(',').map do |n|
            Tag.where(name: n.strip).first_or_create!
        end
    end
end