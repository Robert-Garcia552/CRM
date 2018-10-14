class Case < ApplicationRecord
    belongs_to :clients

    has_secure_password
end
