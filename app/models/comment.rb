class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates :body, presence: true
  validate :only_one_comment

  private

  def only_one_comment
    checked_movie = Movie.find(movie.id)
    errors.add(:base, "You have already commented this movie") unless
      checked_movie.comments.where(user: user).empty?
  end
end
