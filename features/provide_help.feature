Feature: Provide help
  Scenario: rdu is asked for help
    When I successfully run `./rdu.rb -h`
    Then the stdout should contain "Usage: rdu [options]"
