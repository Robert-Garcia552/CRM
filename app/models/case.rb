class Case < ApplicationRecord   
    belongs_to :client

    validates :category, :description, presence: true, on: :create
end
