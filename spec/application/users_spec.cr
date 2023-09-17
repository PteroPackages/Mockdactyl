require "../spec_helper"

struct UsersTest < ATH::Spec::APITestCase
  def test_get_api_key : Nil
    _ = self.post "/keygen"

    assert_response_is_successful
  end

  def test_list_users_without_auth : Nil
    _ = self.get "/api/application/users"

    assert_response_has_status :unauthorized
  end

  def test_list_users_with_auth : Nil
    headers = HTTP::Headers{"Authorization" => "Bearer ptlc_#{get_api_key}"}
    res = self.get "/api/application/users", headers: headers

    assert_response_is_successful
    body = JSON.parse res.body

    body["object"].should eq "list"
    body["data"].raw.should be_a Array(JSON::Any)
    body["data"].as_a.size.should eq 10
  end

  def test_create_user : Nil
    headers = HTTP::Headers{"Authorization" => "Bearer ptlc_#{get_api_key}"}
    data = {
      external_id: "trees",
      username:    "sudowoodo",
      email:       "sudo@woodo.com",
      first_name:  "sudo",
      last_name:   "woodo",
    }.to_json
    res = self.post "/api/application/users", data, headers

    assert_response_is_successful
    body = JSON.parse res.body

    body["object"].should eq "user"
    body["attributes"].raw.should be_a Hash(String, JSON::Any)
    body["attributes"]["id"].as_i.should eq 11
    body["attributes"]["updated_at"].raw.should be_nil
  end

  def test_get_user_by_id : Nil
    headers = HTTP::Headers{"Authorization" => "Bearer ptlc_#{get_api_key}"}
    res = self.get "/api/application/users/11", headers: headers

    assert_response_is_successful
    body = JSON.parse res.body

    body["attributes"]["external_id"].as_s.should eq "trees"
  end

  def test_get_user_by_external_id : Nil
    headers = HTTP::Headers{"Authorization" => "Bearer ptlc_#{get_api_key}"}
    res = self.get "/api/application/users/external/trees", headers: headers

    assert_response_is_successful
    body = JSON.parse res.body

    body["attributes"]["id"].as_i.should eq 11
  end

  # FIXME: missing `#patch` method in Athena spec suite
  #        might have to use raw request

  # def test_update_user : Nil
  #   headers = HTTP::Headers{"Authorization" => "Bearer ptlc_#{get_api_key}"}
  #   data = {
  #     external_id: nil,
  #     username: "sudowoodo",
  #     email: "sudowoodo@example.com",
  #     first_name: "sudo",
  #     last_name: "woodo"
  #   }.to_json
  #   res = self.patch "/api/application/users/11", data, headers

  #   assert_response_is_successful
  #   body = JSON.parse res.body

  #   body["attributes"]["email"].as_s.should eq "sudowoodo@example.com"
  #   body["attributes"]["external_id"]?.should be_nil
  #   body["attributes"]["updated_at"]?.should_not be_nil
  # end

  def test_delete_user : Nil
    headers = HTTP::Headers{"Authorization" => "Bearer ptlc_#{get_api_key}"}
    _ = self.delete "/api/application/users/11", headers: headers

    assert_response_is_successful
    assert_response_has_status :no_content
  end

  def test_get_unknown_user : Nil
    headers = HTTP::Headers{"Authorization" => "Bearer ptlc_#{get_api_key}"}
    _ = self.get "/api/application/users/11", headers: headers

    assert_response_has_status :not_found
  end

  private def get_api_key : String
    res = self.post "/keygen"
    body = JSON.parse res.body

    body["meta"]["secret_token"].as_s
  end
end
