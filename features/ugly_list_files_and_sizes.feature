Feature: Ugly list files and sizes
  Scenario: A directory containing a single file is listed
    Given a directory named "dir1"
    And a 1 byte file named "dir1/file1.txt"
    When I successfully run `./rdu.rb -d dir1 -u`
    Then the stdout should contain:
    """
    {"files":[{"path":"dir1/file1.txt","size":1}]}
    """
