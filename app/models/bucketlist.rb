class Bucketlist < ApplicationRecord
  belongs_to :user, foreign_key: :created_by, class_name: "User"
  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :created_by, presence: true

  def self.get_bucketlist(query_params)
    page = query_params[:page].to_i < 1 ? 1 : query_params[:page].to_i
    limit = query_params[:limit].to_i < 1 ? 20 : query_params[:limit].to_i
    offset = (page - 1) * limit
    query = "%#{query_params[:q]}%"
    where(arel_table[:name].matches(query)).limit(limit).offset(offset)
  end
end
