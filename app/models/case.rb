class Case < ApplicationRecord
    belongs_to :agent

    has_secure_password
end
