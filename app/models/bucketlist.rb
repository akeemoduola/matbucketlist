class Bucketlist < ApplicationRecord
  belongs_to :user, foreign_key: :created_by, class_name: "User"
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :created_by, presence: true

  def self.search(query)
    where(["name ilike ?", "%#{query}%"])
  end
end
