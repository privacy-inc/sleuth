import Foundation

extension Scripts {
    public static let scroll = """
    if (location.hostname.endsWith("google.com")) {
        var style = document.createElement('style');
        style.innerHTML = ":root, body { overflow-y: visible !important; }";
        document.head.appendChild(style);
    } else if (location.hostname.endsWith("youtube.com")) {
        var style = document.createElement('style');
        style.innerHTML = "body { position: unset !important; }";
        document.head.appendChild(style);
    } else if (location.hostname.endsWith("instagram.com")) {
        var style = document.createElement('style');
        style.innerHTML = ":root, html, body, .E3X2T { overflow: unset !important; }";
        document.head.appendChild(style);
    } else if (location.hostname.endsWith("reuters.com")) {
        var style = document.createElement('style');
        style.innerHTML = ":root, html, body { overflow: unset !important; }";
        document.head.appendChild(style);
    } else if (location.hostname.endsWith("thelocal.de")) {
        var style = document.createElement('style');
        style.innerHTML = ".tp-modal-open { overflow: unset !important; }";
        document.head.appendChild(style);
    } else if (location.hostname.endsWith("pinterest.com")) {
        document.body.setAttribute("style", "overflow-y: visible !important");
    } else if (location.hostname.endsWith("bbc.com")) {
        var style = document.createElement('style');
        style.innerHTML = "body { overflow: unset !important; }";
        document.head.appendChild(style);
    }
"""
}
