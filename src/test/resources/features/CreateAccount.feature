@Regression
Feature: Create Account
Background: generate token for all scenarios.
Given url "https://tek-insurance-api.azurewebsites.net"
And path "/api/token"
And request {"username" : "supervisor" , "password" : "tek_supervisor"}
When method post
Then status 200
* def generatedToken = response.token

Scenario: Create new Account happy path
Given path "/api/accounts/add-primary-account"
And request {"email": "mohammad1@gmail.com" , "title" : "Mr." , "fistName" : "Mohammad" , "lastName" : "Shokriyan" , "gender" : "MALE" , "maritalStatus" : "SINGLE" , "employmentStatus" : "Software developer" , "dateOfBirth" : 1988-02-27"}
And header Authorization = "Bearer " + genereatedToken
When method post
Then print response
Then status 201

#2) Test endpoint "/api/accounts/add-primary-account" to add new account with existing email address
# then status code should be 400 - Bad Request , validate respomse