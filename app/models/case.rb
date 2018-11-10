class Case < ApplicationRecord   
    belongs_to :client
    has_many :comments
    has_one_attached :image

    validates :category, :description, presence: true, on: :create
end