#! /bin/sh
# file: examples/equality_test.sh

stringContains() {
    content="$1"
    check_for="$2"
    case "$content" in
        *${check_for}*) echo 'true'  ;;
        *)              echo 'false' ;;
    esac
}

testMvnVersionNoArgs() {
  RESULT=$(./mvnd --version)
  assertEquals "Must execute --version sucessfully: $RESULT" "0" "$?"
  assertNotNull 'Expected --version to produce some output' "$RESULT"

  assertTrue "Maven version not present: $RESULT" $(stringContains "$RESULT" "Apache Maven")
  assertTrue "Java version not present: $RESULT" $(stringContains "$RESULT" "Java version")
  assertTrue "Docker version not present: $RESULT" $(stringContains "$RESULT" "Docker version")
  assertTrue "mvnd version not present: $RESULT" $(stringContains "$RESULT" "Maven meets docker")
  assertTrue "Image not present: $RESULT" $(stringContains "$RESULT" "Image: mvnd")
  assertTrue "Host system not present: $RESULT" $(stringContains "$RESULT" "Host system")
}

# Load shUnit2.
. ./shunit2
