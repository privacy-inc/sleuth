import Foundation

extension Scripts {
    public static let scroll = """
    if (location.host.includes("google.com")) {
        var style = document.createElement('style');
        style.innerHTML = ":root, body { overflow-y: visible !important; }";
        document.head.appendChild(style);
    } else if (location.host.includes("youtube.com")) {
        var style = document.createElement('style');
        style.innerHTML = "body { position: unset !important; }";
        document.head.appendChild(style);
    } else if (location.host.includes("instagram.com")) {
        var style = document.createElement('style');
        style.innerHTML = "body, .E3X2T { overflow: unset !important; }";
        document.head.appendChild(style);
    } else if (location.host.includes("reuters.com")) {
        var style = document.createElement('style');
        style.innerHTML = ":root, html, body { overflow: unset !important; }";
        document.head.appendChild(style);
    } else if (location.host.includes("thelocal.de")) {
        var style = document.createElement('style');
        style.innerHTML = ".tp-modal-open { overflow: unset !important; }";
        document.head.appendChild(style);
    } else if (location.host.includes("pinterest.com")) {
        document.body.setAttribute("style", "overflow-y: visible !important");
    } else if (location.host.includes("bbc.com")) {
        var style = document.createElement('style');
        style.innerHTML = "body { overflow: unset !important; }";
        document.head.appendChild(style);
    }
"""
}
