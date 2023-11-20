 void GaiaOAuthClient::Core::OnUserInfoFetchComplete(
     const net::URLRequestStatus& status,
     int response_code,
     const std::string& response) {
   std::string email;
   if (response_code == net::HTTP_OK) {
     scoped_ptr<Value> message_value(base::JSONReader::Read(response));
    if (message_value.get() &&
        message_value->IsType(Value::TYPE_DICTIONARY)) {
      scoped_ptr<DictionaryValue> response_dict(
          static_cast<DictionaryValue*>(message_value.release()));
      response_dict->GetString(kEmailValue, &email);
    }
  }

  if (email.empty()) {
    delegate_->OnNetworkError(response_code);
  } else {
    delegate_->OnRefreshTokenResponse(
        email, access_token_, expires_in_seconds_);
  }
}
