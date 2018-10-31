require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  describe "POST #create" do
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }
    before { sign_in(user) }

    context "with valid params" do
      it "creates a new Comment and redirects to movies#show with flash[:notice]" do
        expect { post :create, params: { comment: attributes_for(:comment), movie_id: movie.id } }
          .to change(Comment, :count).by(1)
        expect(response).to redirect_to movie_path(movie)
        expect(flash[:notice]).to eq("Comment created successfully")
      end
    end

    context "with invalid params" do
      it "does not save a new Comment to db and re-renders the movies/show template
          with flash[:alert]" do
        invalid_comment = attributes_for(:comment, :invalid)
        expect { post :create, params: { comment: invalid_comment, movie_id: movie.id } }
          .not_to change(Comment, :count)
        expect(response).to render_template "movies/show"
        expect(flash[:alert]).to include "Body can't be blank"
      end
    end
  end

  describe "DELETE #destroy" do
    let(:comment) { create(:comment) }
    let(:movie) { comment.movie }
    before { sign_in(comment.user) }

    it "deletes the comment and redirects to movies#show with flash[:notice]" do
      expect { delete :destroy, params: { id: comment, movie_id: movie.id } }
        .to change(Comment, :count).by(-1)
      expect(response).to redirect_to movie_path(movie)
      expect(flash[:notice]).to eq "The comment has been removed"
    end
  end
end
