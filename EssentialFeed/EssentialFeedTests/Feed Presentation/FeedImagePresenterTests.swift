//
//  FeeedImagePresenterTests.swift
//  EssentialFeedTests
//
//  Created by Daren Hayward on 20/03/2022.
//

import XCTest
import EssentialFeed

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool

    var hasLocation: Bool {
        return location != nil
    }
}

protocol FeedImageView {
    associatedtype Image

    func display(_ model: FeedImageViewModel<Image>)
}


final class FeedImagePresenter<View: FeedImageView, Image> where View.Image == Image {
    private let view: View
    private let imageTransformer: (Data) -> Image?

    init (view: View, imageTransformer: @escaping (Data) -> Image?) {
        self.view = view
        self.imageTransformer = imageTransformer

    }

    func didStartLoadingImageData(for model: FeedImage) {
        view.display(FeedImageViewModel(
            description: model.description,
            location: model.location,
            image: nil,
            isLoading: true,
            shouldRetry: false))
    }

    func didFinishLoadingImageData(with data: Data, for model: FeedImage) {
        guard let image = imageTransformer(data) else {
            return view.display(FeedImageViewModel(
                description: model.description,
                location: model.location,
                image: nil,
                isLoading: false,
                shouldRetry: true))
        }

        view.display(FeedImageViewModel(
            description: model.description,
            location: model.location,
            image: image,
            isLoading: false,
            shouldRetry: false))
    }

    func didFinishLoadingImageData(with error: Error, for model: FeedImage) {
        view.display(FeedImageViewModel(
            description: model.description,
            location: model.location,
            image: nil,
            isLoading: false,
            shouldRetry: true))
    }
}

class FeedImagePresenterTests: XCTestCase {

    func test_init_doesNotSendImagesToView() {
        let (_, view) = makeSUT()

        XCTAssertTrue(view.messages.isEmpty, "Expected no view images")
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
        trackForMemoryLeaks(view)
        trackForMemoryLeaks(sut)
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
