class Todo < ApplicationRecord
    # Validation for todo item; must not be empty
    validates :item, presence: true
end