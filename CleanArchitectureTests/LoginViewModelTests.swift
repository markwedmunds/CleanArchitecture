import XCTest
@testable import CleanArchitecture

class MockLoginUseCase: LoginUseCaseProtocol {
  var shouldLogin = false

  func execute(username: String, password: String) -> Bool {
    return shouldLogin
  }
}

class LoginViewModelTests: XCTestCase {
  var loginUseCase: MockLoginUseCase!
  var viewModel: LoginViewModel!

  @MainActor override func setUpWithError() throws {
    super.setUp()
    loginUseCase = MockLoginUseCase()
    viewModel = LoginViewModel(loginUseCase: loginUseCase)
  }

  func testViewModelLoginSuccess() async throws {
    loginUseCase.shouldLogin = true
    await viewModel.login()
    let isLoggedIn = await viewModel.isLoggedIn
    XCTAssertTrue(isLoggedIn)
  }

  func testViewModelLoginFailure() async throws {
    loginUseCase.shouldLogin = false
    await viewModel.login()
    let isLoggedIn = await viewModel.isLoggedIn
    XCTAssertFalse(isLoggedIn)
  }
}
