class User < ActiveRecord::Base
  has_secure_password

with_options if: :first_name do |name|
  name.validates :first_name, length: { minimum: 3 },
    format: { with: /\A[a-zA-Z]+\z/, message: "should only contain letters" },
    presence: true
  name.validates :last_name, length: { minimum: 2 },
    format: { with: /\A[a-zA-Z]+\z/, message: "should only contain letters" }, presence: true
  name.validates :email, uniqueness: true,
    length: { maximum: 255 },
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
    presence: true

  name.validates :password, length: { in: 8..72 },
  format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d.*\d)(?=.*\w).+\z/, message: "should contain one capital letter, one punctuation symbol, two numbers, and length between 8 and 72 characters" },
  presence: true
end

  # validates_exclusion_of :password, in: ->(users) { [@user.first_name, @user.last_name] },
  #   message: 'should not be the same as your First or Last name'

  validate :check_email_and_password

  def check_email_and_password
    errors.add(:password, "can't be the same as email") if email == password
  end

end
