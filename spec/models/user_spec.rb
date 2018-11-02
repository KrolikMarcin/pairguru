require "rails_helper"

describe User do
  it { is_expected.to allow_value("+48 999 888 777").for(:phone_number) }
  it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
  it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
  it { is_expected.not_to allow_value("+48 aaa bbb ccc").for(:phone_number) }
  it { is_expected.not_to allow_value("aaa +48 aaa bbb ccc").for(:phone_number) }
  it { is_expected.not_to allow_value("+48 999 888 777\naseasd").for(:phone_number) }

  describe ".best_commenters" do
    before do
      create_list(:user, 2, :with_many_comments)
    end
    let!(:users) { create_list(:user, 10, :with_many_comments) }
    let!(:maped_users) do
      users.map do |user|
        { id: user.id, user: user.name, count: user.comments.count }
      end.reverse
    end

    subject do
      described_class.best_commenters.to_ary.map do |user|
        { id: user.id, user: user.name, count: user.comments.count }
      end
    end

    it "returns 10 users with the most comments in last week, sorted by the sum of comments" do
      expect(subject).to eq(maped_users)
    end

    it "returns sum of comments only from last week" do
      users.each { |user| user.comments << create_list(:comment, 2, :outdated_week, user: user) }
      expect(described_class.best_commenters.to_ary.pluck(:count)).to eq maped_users.pluck(:count)
    end
  end
end
