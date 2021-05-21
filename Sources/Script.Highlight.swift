import Foundation

extension Script {
    public static let highlight = """
if (!getSelection().isCollapsed) {
    var privacy_mark = document.createElement("mark");
    privacy_mark.style.setProperty("background-color", "rgba(180, 220, 240, 0.7)", "important");
    getSelection().getRangeAt(0).surroundContents(privacy_mark);
    setTimeout(function () {
        getSelection().collapse(privacy_mark, 1)
    }, 100)
    setTimeout(function (privacy_old) {
        privacy_old.outerHTML = privacy_old.innerHTML;
    }, 2000, privacy_mark)
    getSelection().getRangeAt(0).getBoundingClientRect().top;
}
"""
}
