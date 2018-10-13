class Client < ApplicationRecord
    has_many :cases
    belongs_to :agent
end
