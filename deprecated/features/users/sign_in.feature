Feature:
  As a #bookcamping user
  I want to sign in

  @wip
  Scenario: User sign in succesfully
    Given there's no user called "María"
    When we receive an auth of "María"
    Then I should see "María"
    Then I should see "Bienvenida a #bookcamping."

  @wip
  Scenario: User sign in with twitter
    Given there's no user called "name"
    When we receive a "twitter" auth to "name"
    And I go to profile page
    Then I should see "name"
    And I should see "twitter"
    And I should see "@name"

  @wip
  Scenario: User sign in with google
    Given there's no user called "name"
    When we receive a "google" auth to "name"
    And I go to profile page
    Then I should see "name"
    And I should see "google"
    And I should see "name@email.com"

  @wip
  Scenario: User sign in with facebook



