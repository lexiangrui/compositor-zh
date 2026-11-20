import Foundation
import Testing
@testable import Compositor

struct LocalizationTests {
    private func chineseBundle() throws -> Bundle {
        let url = try #require(Bundle.main.url(forResource: "zh-Hans", withExtension: "lproj"))
        return try #require(Bundle(url: url))
    }

    @Test func simplifiedChineseCatalogIsPackaged() throws {
        let bundle = try chineseBundle()
        #expect(bundle.localizedString(forKey: "New canvas", value: nil, table: nil) == "新建画布")
        #expect(bundle.localizedString(forKey: LayerBlendMode.multiply.rawValue, value: nil, table: nil) == "正片叠底")
        #expect(bundle.localizedString(forKey: "Compositor Project", value: nil, table: "InfoPlist") == "Compositor 项目")
    }

    @Test func formatCanReorderFilenameAndCount() throws {
        let bundle = try chineseBundle()
        let key = "%lld of these files already exist in “%@”. Replace them?"
        let format = bundle.localizedString(forKey: key, value: nil, table: nil)
        #expect(String(format: format, 2, "Logo 100%") == "“Logo 100%”中已有 2 个同名文件。要替换它们吗？")
    }

    @Test func missingKeyFallsBackWithoutChangingData() {
        let name = "__untranslated_test_图层__"
        #expect(L(name) == name)
        #expect(LayerBlendMode.multiply.rawValue == "Multiply")
    }
}
