@Smoke @Regression
Feature: Security test. Token Generation test
@Security
  	Scenario: generate token with valid username and password.
  	Given url "https://tek-insurance-api.azurewebsites.net/"
  	And path "/api/token"
  	And request {"username" : "supervisor" , "password" : "tek_supervisor"}
 	 	When method post
  	Then status 200
  	And print response
@negative
  	Scenario: generate token with invalid username and password.
    Given url "https://tek-insurance-api.azurewebsites.net/"
    And path "/api/token"
    And request {"invalid_username" : "supervisor" , "invalid_password" : "tek_supervisor"}
    When method post
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "USER_NOT_FOUND"
    
 @Security
    Scenario: valid username and invalid password.
    Given url "https://tek-insurance-api.azurewebsites.net/"
    And path "/api/token"
    And request {"username" : "supervisor" , "invalid_password" : "tek_supervisor"}
    When method post
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage == "USER_NOT_FOUND"
    
  
