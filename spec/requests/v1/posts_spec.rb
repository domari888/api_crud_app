require 'rails_helper'

RSpec.describe "V1::Posts", type: :request do
  describe "GET #index" do
    context "投稿が存在するとき" do
      before { create_list(:post, 3) }
      subject { get(v1_posts_path) }
      it "リクエストが成功すること" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "posts テーブルのレコード数と取得した投稿数が一致すること" do
        subject
        json = JSON.parse(response.body)
        expect(json.size).to eq 3
      end

      it "最初の投稿が id, title, content のキーを持つこと" do
        subject
        json = JSON.parse(response.body)
        expect(json[0].keys).to eq ["id", "title", "content"]
      end

      it "最初の投稿の id が取得できること" do
        subject
        json = JSON.parse(response.body)
        expect(json[0]["id"]).to eq Post.first.id
      end

      it "最初の投稿の title が取得できること" do
        subject
        json = JSON.parse(response.body)
        expect(json[0]["title"]).to eq Post.first.title
      end

      it "最初の投稿の content が取得できること" do
        subject
        json = JSON.parse(response.body)
        expect(json[0]["content"]).to eq Post.first.content
      end
    end
  end

  describe "GET #show" do
    subject { get(v1_post_path(post_id)) }
    context "指定した id の投稿が存在するとき" do
      let(:post) { create(:post) }
      let(:post_id) { post.id }
      it "指定した id の投稿を取得できること" do
        subject
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json["title"]).to eq post.title
        expect(json["content"]).to eq post.content
      end
    end

    context "指定した id の投稿が存在しないとき" do
      let(:post_id) { 0 }
      it "エラーが発生すること" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

  end
  
  describe "POST #create" do
    
  end

  describe "PATCH #update" do
    
  end

  describe "DELETE #destroy" do
    
  end
end