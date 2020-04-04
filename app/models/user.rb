# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments
  has_many :favorites, dependent: :destroy
  has_many :favorited_books, through: :favorites, source: :book
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  attachment :profile_image, destroy: false

  # バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: { maximum: 20, minimum: 2 }
  validates :introduction, length: { maximum: 50 }

  def already_favorited?(book)
    favorites.exists?(book_id: book.id)
  end

  # follow関連
  def follow(other_user)
    unless self == other_user
      relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end
end
