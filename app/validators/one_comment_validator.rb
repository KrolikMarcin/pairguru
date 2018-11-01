class OneCommentValidator < ActiveModel::Validator
  def validate(record)
    movie = record.movie
    user = record.user
    if movie.comments.where(user_id: user).exists?
      record.errors.add(
        :base, "You have already commented this movie. First, delete the previous comment"
      )
    end
  end
end
