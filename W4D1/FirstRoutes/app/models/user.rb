# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  username   :string           not null
#

class User < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true

  has_many :contacting_friends,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Contact,
    dependent: :destroy

  has_many :contact_shares,
    dependent: :destroy

  has_many :shared_contacts,
    through: :contact_shares,
    source: :contactee

end
