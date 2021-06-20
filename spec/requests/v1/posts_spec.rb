require 'rails_helper'

RSpec.describe "V1::Posts", type: :request do
  describe "GET #index" do
    context "投稿が存在するとき" do
      before { create_list(:post, 3) }
      subject { get(v1_posts_path) }
      it "投稿一覧が取得できること" do
        subject
        json = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(json.size).to eq 3
        expect(json[0].keys).to eq %w[id title content]
        expect(json[0]["id"]).to eq Post.first.id
        expect(json[0]["title"]).to eq Post.first.title
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
    subject { post(v1_posts_path, params: post_params) }
    context "パラメータが正常なとき" do
      let(:post_params) { { post: attributes_for(:post) } }
      it "データが保存されること" do
        expect { subject }.to change { Post.count }.by(1)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH #update" do
    subject { patch(v1_post_path(post_id), params: post_params) }
    let(:post) { create(:post) }
    let(:post_id) { post.id }
    context "パラメータが正常なとき" do
      let(:post_params) { { post: attributes_for(:post) } }
      it "データが更新されること" do
        new_post = post_params[:post]
        expect { subject }
          .to change { post.reload.title }
          .from(post.title).to(new_post[:title])
          .and change { post.reload.content }
          .from(post.content).to(new_post[:content])
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "DELETE #destroy" do
    subject { delete(v1_post_path(post.id))}
    let!(:post) { create(:post) }
    context "投稿が存在するとき" do
      it "データが削除されること" do
        expect { subject }.to change { Post.count }.by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end