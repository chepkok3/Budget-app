class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :expenses, dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  protected

  def confirmation_required?
    false
  end
end
