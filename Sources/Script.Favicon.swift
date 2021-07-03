import Foundation

extension Script {
    static let favicon = """
    const _privacy_incognit_favicon = document.querySelector("link[rel*='icon']");
    if (_privacy_incognit_favicon != null) {
        webkit.messageHandlers.favicon.postMessage(_privacy_incognit_favicon.href);
    } else {
        webkit.messageHandlers.favicon.postMessage(location.origin + "/favicon.ico");
    }
"""
}
