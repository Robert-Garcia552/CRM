class Agent < ApplicationRecord
    attr_accessor :remember_token, :reset_token
    before_save   :downcase_email, :capitalize_name

    validates :first_name, :last_name, :birthdate, :email, :phone_number, presence: true
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
    validates_length_of :phone_number, in: 10..13
    validates :email, uniqueness: true

    has_secure_password

    def next_three_events
        attending_events.future.first(3)
    end

    # Returns the hash digest of the given string.
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def self.new_token
        SecureRandom.urlsafe_base64
    end

    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # Returns true if the given token matches the digest.
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # Forgets a user.
    def forget
        update_attributes(:remember_digest => nil)
    end

    # sets the password reset attribute.
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest,  User.digest(reset_token))
        update_attribute(:reset_sent_at, Time.zone.now)
      end

    # Sends password reset email.
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    # Returns true if a password reset has expired.
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    private

    # Converts email to all lower-case.
    def downcase_email
        self.email = email.downcase
    end

    def capitalize_name
      self.first_name = first_name.capitalize
      self.last_name = last_name.capitalize
    end   
end
