#3) Generate a valid token and verify it with below requirement.
#test API endpoint "/api/token/verify" with valid token.
#Status should be 200 - bad request and response is true.
Feature: Security Test. Verify Token Test.

  Scenario: Verify valid token.
    Given url "https://tek-insurance-api.azurewebsites.net/"
    And path "/api/token"
    And request {"username" : "supervisor" , "password" : "tek_supervisor"}
    When method post
    Then status 200
    And print response
    * def generatedToken = response.token
    Given path "/api/token/verify"
    And param username = "supervisor"
    And param token = generatedToken
    When method get
    Then status 200
    And print response

  #2) test api endpoint "/api/token/verify" with invalid token.
  # Note: since it is invalid token it can be any random string. You dont need to generate a new token.
  # Status should be 400 - bad request and response should be TOKEN_EXPIRED
  # There is an open defect for this scenario already
  Scenario: verify invalid token
    Given url "https://tek-insurance-api.azurewebsites.net/"
    Given path "/api/token/verify"
    And param username = "supervisor"
    And param token = "invalid-token-random-string"
    When method get
    Then status 400
    And print response

  #3) test api endpoint "/api/token/verify" with vaild token.
  # and invalid username, then status should be 400
  #and errorMessage = Wrong username send along with Token
  Scenario: invalid username with valid token
    Given url "https://tek-insurance-api.azurewebsites.net/"
    Given path "/api/token"
    And request {"username" : "supervisor" , "password" : "tek_suervisor"}
    When method post
    Then status 200
    * def errorMessage = response.errorMessage
    Given path "/api/token/verify"
    And param username = "invalid-username"
    And param token = generatedToken
    When method get
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "Wrong Username send along with Token"
