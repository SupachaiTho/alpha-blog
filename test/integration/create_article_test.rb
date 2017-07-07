require 'test_helper'

class CreateArticleTest <  ActionDispatch::IntegrationTest
    
    def setup
       @user = User.create(username: "john",email: "john@example.com",password: "password",admin: false) 
    end
    
    test "should create new article success" do
        sign_in_as(@user, "password")
        get new_article_path
        assert_template 'articles/new'
        assert_difference 'Article.count',1 do
            post_via_redirect articles_path, 
            article: {title: "this is test article",description: "this is description of test create article", category_ids: []}
        end
        assert_template 'articles/show'
        assert_match "this is test article", response.body
    end
    
    test "invalid article submission result in failure" do
        sign_in_as(@user, "password")
        get new_article_path
        assert_template 'articles/new'
        assert_no_difference 'Article.count' do
            post articles_path,
            article: {title: " ",description: " ", category_ids: []}
        end
        assert_template 'articles/new'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end
end