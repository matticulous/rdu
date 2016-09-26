Feature: Pretty list files and sizes
  Scenario: A directory containing a single file is listed
    Given a directory named "dir1"
    And a 1 byte file named "dir1/file1.txt"
    When I successfully run `./rdu.rb -d dir1`
    Then the stdout should contain:
    """
    {
      "files": [
        {
          "dir1/file1.txt": 1
        }
      ]
    }
    """
  Scenario: A directory containing a single file and an empty directory is listed
    Given a directory named "dir1"
    And a 100 byte file named "dir1/file1.txt"
    And a directory named "dir1/subdir1"
    When I successfully run `./rdu.rb -d dir1`
    Then the stdout should contain:
    """
    {
      "files": [
        {
          "dir1/file1.txt": 100
        }
      ]
    }
    """
  Scenario: A directory containing a single file and populated subdirectory is listed
    Given a directory named "dir1"
    And a 1 byte file named "dir1/file1.txt"
    And a directory named "dir1/subdir1"
    And a 2 byte file named "dir1/subdir1/file2.txt"
    When I successfully run `./rdu.rb -d dir1`
    Then the stdout should contain:
    """
    {
      "files": [
        {
          "dir1/file1.txt": 1
        },
        {
          "dir1/subdir1/file2.txt": 2
        }
      ]
    }
    """
