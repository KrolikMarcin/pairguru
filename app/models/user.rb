# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :comments, dependent: :destroy
  validates :phone_number, format: { with: /\A[+]?\d+(?>[- .]\d+)*\z/, allow_nil: true }

  def self.best_commenters
    joins(:comments).select("users.id, users.name, count(comments.id) as count")
      .where(comments: { created_at: (1.week.ago..Time.current) }).group(:id)
      .order("count DESC").limit(10)
  end
end
