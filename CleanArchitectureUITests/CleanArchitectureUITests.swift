import XCTest

final class CleanArchitectureUITests: XCTestCase {
  var app: XCUIApplication!

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
    app.launch()
  }

  func testLoginSuccess() {
    let usernameField = app.textFields["Username"]
    let passwordField = app.secureTextFields["Password"]
    let loginButton = app.buttons["Login"]

    usernameField.tap()
    usernameField.typeText("demo")

    passwordField.tap()
    passwordField.typeText("password")

    loginButton.tap()

    XCTAssertTrue(app.staticTexts["Logged In Successfully!"].waitForExistence(timeout: 5))
  }

  func testLoginIncorrectUserFailure() {
    let usernameField = app.textFields["Username"]
    let passwordField = app.secureTextFields["Password"]
    let loginButton = app.buttons["Login"]

    usernameField.tap()
    usernameField.typeText("wrongUser")

    passwordField.tap()
    passwordField.typeText("wrongPassword")

    loginButton.tap()

    XCTAssertTrue(app.staticTexts["User not found"].waitForExistence(timeout: 5))
    XCTAssertFalse(app.staticTexts["Logged In Successfully!"].exists)
  }

  func testLoginIncorrectPasswordFailure() {
    let usernameField = app.textFields["Username"]
    let passwordField = app.secureTextFields["Password"]
    let loginButton = app.buttons["Login"]

    usernameField.tap()
    usernameField.typeText("demo")

    passwordField.tap()
    passwordField.typeText("wrongPassword")

    loginButton.tap()

    XCTAssertTrue(app.staticTexts["Incorrect password"].waitForExistence(timeout: 5))
    XCTAssertFalse(app.staticTexts["Logged In Successfully!"].exists)
  }
}
