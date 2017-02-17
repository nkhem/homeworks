# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  track_name :string           not null
#  track_type :string
#  lyrics     :string
#  album_id   :string           not null
#

class Track < ActiveRecord::Base
  validates :title, :album_id, presence: true
  validates :track_type, inclusion: { in: ["bonus", "regular"]}

  belongs_to :album
  has_one :band,
    through: :album,
    source: :band

end
