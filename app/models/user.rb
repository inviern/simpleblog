class User < ActiveRecord::Base
  NAME_REGEXP   = /\A[a-z0-9_-]*\z/i
  EMAIL_REGEXP  = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  authenticates_with_sorcery!

  before_save :downcase_email

  validates :name,
            presence: true,
            length: { maximum: 32 },
            format: { with: NAME_REGEXP },
            uniqueness: { case_sensitive: false }

  validates :email,
            presence: true,
            length: { maximum: 32 },
            format: { with: EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }

  validates :password,
            presence: true,
            length: { minimum: 6, maximum: 32 },
            confirmation: true

  validates :password_confirmation, presence: true

  private

  def downcase_email
    self.email = email.downcase
  end

end
