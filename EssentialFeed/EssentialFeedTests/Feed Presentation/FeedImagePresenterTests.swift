//
//  FeeedImagePresenterTests.swift
//  EssentialFeedTests
//
//  Created by Daren Hayward on 20/03/2022.
//

import XCTest
import EssentialFeed

class FeedImagePresenterTests: XCTestCase {

    func test_init_doesNotSendMessagesToView() {
        let (_, view) = makeSUT()

        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }

    func test_didStartLoadingImageData_displaysLoadingImage() {
        let (sut, view) = makeSUT()
        let image = uniqueImage()

        sut.didStartLoadingImageData(for: image)

        expect(for: view, with: image, hasTransformatedData: .none, isLoading: true, shouldRetry: false)

    }

    func test_didFinishLoadingImageData_displaysRetryOnFailedImageTransformation() {
        let (sut, view) = makeSUT(imageTransformer: alwaysFailsTransformer)
        let image = uniqueImage()

        sut.didFinishLoadingImageData(with: Data(), for: image)

        expect(for: view, with: image, hasTransformatedData: .none, isLoading: false, shouldRetry: true)

    }

    func test_didFinishLoadingImageData_displaysImageOnSuccessfulTransformation() {
        let image = uniqueImage()
        let transformedData = AnyImage()
        let (sut, view) = makeSUT(imageTransformer: { _ in transformedData })

        sut.didFinishLoadingImageData(with: Data(), for: image)

        expect(for: view, with: image, hasTransformatedData: transformedData, isLoading: false, shouldRetry: false)

    }

    func test_didFinishLoadingImageDataWithError_displaysRetry() {
        let (sut, view) = makeSUT()
        let image = uniqueImage()

        sut.didFinishLoadingImageData(with: anyNSError(), for: image)

        expect(for: view, with: image, hasTransformatedData: .none, isLoading: false, shouldRetry: true)
    }

    // MARK: - Helpers

    private func makeSUT(
        imageTransformer: @escaping (Data) -> AnyImage? = { _ in nil },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: FeedImagePresenter<ViewSpy, AnyImage>, view: ViewSpy) {
        let view = ViewSpy()
        let sut = FeedImagePresenter(view: view, imageTransformer: imageTransformer)
        trackForMemoryLeaks(view, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, view)
    }

    private func expect(
        for view: ViewSpy,
        with image: FeedImage,
        hasTransformatedData: AnyImage?,
        isLoading: Bool,
        shouldRetry: Bool,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(view.messages.count, 1, file: file, line: line)
        let message = view.messages.first
        XCTAssertEqual(message?.description, image.description, file: file, line: line)
        XCTAssertEqual(message?.location, image.location, file: file, line: line)
        XCTAssertEqual(message?.image, hasTransformatedData, file: file, line: line)
        XCTAssertEqual(message?.isLoading, isLoading, file: file, line: line)
        XCTAssertEqual(message?.shouldRetry, shouldRetry, file: file, line: line)

    }

    private var alwaysFailsTransformer: (Data) -> AnyImage? {
        return { _ in nil }
    }

    private struct AnyImage: Equatable {}

    private class ViewSpy: FeedImageView {
        private(set) var messages = [FeedImageViewModel<AnyImage>]()

        func display(_ model: FeedImageViewModel<AnyImage>) {
            messages.append(model)
        }

    }
}
