import XCTest
import AppKit
@testable import MrEditorCore

final class PrintLayoutTests: XCTestCase {
    func testPrintingWrapsAtPaperWidthWithoutShrinkingFontOrChangingEditor() {
        let source = NSTextView(frame: NSRect(x: 0, y: 0, width: 1800, height: 600))
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byClipping
        source.textStorage?.setAttributedString(NSAttributedString(
            string: String(repeating: "打印文字 long line ", count: 100),
            attributes: [.font: NSFont.systemFont(ofSize: 20), .paragraphStyle: style]))
        let info = NSPrintInfo.shared.copy() as! NSPrintInfo
        info.paperSize = NSSize(width: 595, height: 842)
        info.leftMargin = 36
        info.rightMargin = 36
        let output = EditableViewer.makePrintView(from: source, printInfo: info)
        XCTAssertEqual(output.frame.width, 523, accuracy: 1)
        XCTAssertGreaterThan(output.frame.height, 100)
        XCTAssertEqual((output.textStorage?.attribute(.font, at: 0, effectiveRange: nil) as? NSFont)?.pointSize, 20)
        XCTAssertEqual(source.frame.width, 1800)
        XCTAssertEqual((source.textStorage?.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle)?.lineBreakMode, .byClipping)
    }
}
