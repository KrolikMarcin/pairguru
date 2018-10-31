require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "validations" do
    subject { build(:comment) }
    it { is_expected.to validate_presence_of(:body) }

    describe "#only_one_comment" do
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
          expect(comment.errors.messages[:base]).to include "You have already commented this movie"
        end
      end
    end
  end
end
