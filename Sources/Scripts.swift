import Foundation

public struct Scripts {
    public static let dark = """
function dark() {
    if (document.styleSheets && document.styleSheets.length > 0) {
        for (var i = 0; i < document.styleSheets.length; i++) {
            if (document.styleSheets[i].cssRules) {
                for (var j = 0; j < document.styleSheets[i].cssRules.length; j++) {
                    if (document.styleSheets[i].cssRules[j] instanceof CSSMediaRule &&
                        document.styleSheets[i].cssRules[j].media.mediaText.indexOf('dark') > 0) {
                         /Users/vaux/dev/Sleuth/Sources/Dark.swift   return true;
                    }
                }
            }
        }
        return false;
    }
    return true;
}

if (!dark()) {
    var style = document.createElement('style');
    style.innerHTML = ":root, img, [style*=background-image], [class*=video-thumbnail-img], #player-container-id { filter: invert(1) hue-rotate(.5turn); }";
    document.head.appendChild(style);
}
if true {
    var style = document.createElement('style');
    style.innerHTML = ":root, img, [style*=background-image], [class*=video-thumbnail-img], #player-container-id { filter: invert(1) hue-rotate(.5turn); }";
    document.head.appendChild(style);
}
"""
    
    public static let scroll = """
    if (location.host.includes("google.com")) {
        var style = document.createElement('style');
        style.innerHTML = ":root { overflow-y: visible !important; }";
        document.head.appendChild(style);
    }
"""
}
