class Case < ApplicationRecord   
    belongs_to :client
    has_many :comments
    has_many_attached :images

    validates :category, :description, :status, presence: true, on: :create
end