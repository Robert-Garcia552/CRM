class Client < ApplicationRecord
    has_many :cases
    belongs_to :agent

    validates :first_name, :last_name, :phone_number, :email, presence: true, on: :create
end