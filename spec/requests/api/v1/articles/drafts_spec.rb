require "rails_helper"
#テストの概要
#  -自分が書いた記事の下書き一覧を取得する
#    -記事一覧が取得出来る
#
#  -自分が書いた特定の記事を取得する
#    -特定の記事が取得出来る
#

RSpec.describe "Api::V1::Articles::Drafts", type: :request do
  describe "GET /api/v1/articles/drafts" do

    subject { get(api_v1_articles_drafts_path, headers: headers) }

    context "自分が書いた記事の下書き一覧を取得する" do
      it "記事一覧が取得出来る" do
        subject
      end
    end
  end
end
