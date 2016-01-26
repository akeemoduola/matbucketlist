class Item < ApplicationRecord
  belongs_to :bucketlist

  validates :name, presence: true
  validates :bucketlist, presence: true
end
