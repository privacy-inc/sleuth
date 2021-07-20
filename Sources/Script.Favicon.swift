import Foundation

extension Script {
    static let favicon = """
    var _privacy_incognit_favicon = document.querySelector("link[rel='shortcut icon']");

    if (_privacy_incognit_favicon == null) {
        _privacy_incognit_favicon = document.querySelector("link[rel='icon']");
        
        if (_privacy_incognit_favicon == null) {
            _privacy_incognit_favicon = document.querySelector("link[rel='shortcut icon']");

            if (_privacy_incognit_favicon == null) {
                _privacy_incognit_favicon = document.querySelector("link[rel='apple-touch-icon']");

                if (_privacy_incognit_favicon == null) {
                    _privacy_incognit_favicon = document.querySelector("link[rel*='icon']");
                }
            }
        }
    }
    
    if (_privacy_incognit_favicon != null && !_privacy_incognit_favicon.href.endsWith('.svg')) {
        webkit.messageHandlers.\(Message.favicon.rawValue).postMessage(_privacy_incognit_favicon.href);
    } else {
        webkit.messageHandlers.\(Message.favicon.rawValue).postMessage(location.origin + "/favicon.ico");
    }
"""
}
