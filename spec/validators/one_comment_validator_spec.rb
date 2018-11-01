require "rails_helper"

describe "OneCommentValidator" do
  context "valid params. User has not yet already commented this movie" do
    it "comment be valid" do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end

  context "invalid params. User has already commented this movie" do
    it "comment not be valid, and add error to :base" do
      movie = create(:movie, :with_comments)
      comment = build(:comment, user: movie.comments.first.user, movie: movie)
      expect(comment).to_not be_valid
      expect(comment.errors.messages[:base])
        .to include "You have already commented this movie. First, delete the previous comment"
    end
  end
end
