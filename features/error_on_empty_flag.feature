Feature: Error on empty flag
  Scenario: rdu is called without any flags
    When I run `./rdu.rb`
    Then the stderr should contain "Error: you must supply a directory"
    And the stdout should contain "Usage: rdu [options]"
