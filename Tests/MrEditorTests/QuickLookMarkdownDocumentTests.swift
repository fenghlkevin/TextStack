import XCTest
@testable import MrEditorCore

final class QuickLookMarkdownDocumentTests: XCTestCase {
    private func read(_ data: Data, limit: Int = 1024) throws -> String {
        let file = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString + ".md")
        try data.write(to: file)
        defer { try? FileManager.default.removeItem(at: file) }
        return try QuickLookMarkdownDocument.read(file, limit: limit)
    }
    func testUnicodeAndByteOrderMarks() throws {
        let text = "# 中文 😀\n"
        XCTAssertEqual(try read(Data(text.utf8)), text)
        XCTAssertEqual(try read(Data([0xef, 0xbb, 0xbf]) + Data(text.utf8)), text)
        XCTAssertEqual(try read(XCTUnwrap(text.data(using: .utf16))), text)
    }
    func testTruncationDoesNotSplitUTF8Character() throws {
        let output = try read(Data("中文😀末尾".utf8), limit: 8)
        XCTAssertTrue(output.hasPrefix("中文\n\n> "))
        XCTAssertFalse(output.contains("末尾"))
    }
    func testTruncationKeepsCompleteLines() throws {
        let output = try read(Data("# Title\nLong paragraph".utf8), limit: 12)
        XCTAssertTrue(output.hasPrefix("# Title\n\n> "))
    }
    func testChineseLegacyEncoding() throws {
        let text = "皇帝是公司出的游戏，第一节：游戏的操作。\r\n智慧、武术、魅力、才艺和快乐。"
        let data = try XCTUnwrap(text.data(using: DetectedEncoding.gb18030.stringEncoding))
        XCTAssertEqual(EncodingDetector.detect(data), .gb18030)
        XCTAssertEqual(try read(data), text)
        let output = try read(data, limit: 5)
        XCTAssertTrue(output.hasPrefix("皇帝\n\n> "))
    }
    func testJapaneseLegacyPreview() throws {
        let text = "日本語のゲーム攻略です。\n"
        for encoding: DetectedEncoding in [.shiftJIS, .eucJP] {
            let data = try XCTUnwrap(text.data(using: encoding.stringEncoding))
            XCTAssertEqual(EncodingDetector.detect(data), encoding)
            XCTAssertEqual(try read(data), text)
        }
    }
    func testInvalidEncodingFails() {
        XCTAssertThrowsError(try read(Data([0xff, 0x80, 0xff])))
    }
    func testDirectoryRejected() {
        XCTAssertThrowsError(try QuickLookMarkdownDocument.read(FileManager.default.temporaryDirectory))
    }
}
