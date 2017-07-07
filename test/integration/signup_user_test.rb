require 'test_helper'

class SignupUserTest <  ActionDispatch::IntegrationTest
    
    test "should signup success" do
        get signup_path
        assert_template 'users/new'
        assert_difference 'User.count',1 do
            post_via_redirect users_path, user: {username: "jor",email: "jor@example.com", password: "password"}
        end
        assert_template 'users/show'
        assert_match "jor", response.body
    end
    
    test "invalid user submission resild in failure" do
        get signup_path
        assert_template 'users/new'
        assert_no_difference 'User.count' do
            post users_path, user: {username: " ",email: " ", password: "password"}
        end
        assert_template 'users/new'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end
end