pragma Singleton
import QtQuick

QtObject {
    // ACCENT
    property color accent: "#F19A5B" // TODO: this is kept writable so that i can eventually have a mechanism to change this
    readonly property color accentFaint: Qt.alpha(controlAccent, 0.08)
    readonly property color accentSoft: Qt.alpha(controlAccent, 0.18)
    readonly property color accentStrong: Qt.lighter(accent, 1.10)
    readonly property color background: light ? "#E6E8EA" : "#0D0F12"

    // EDGES
    readonly property color border: Qt.alpha(text, 0.10)
    readonly property color borderStrong: Qt.alpha(text, 0.16)
    readonly property color controlAccent: warmAccent && !light ? Qt.tint(accent, Qt.alpha(fireHalo, 0.20)) : accent
    readonly property color divider: Qt.alpha(text, 0.08)
    readonly property color emberCore: warmAccent && !light ? "#FFF1CF" : "#FFF9EF"
    readonly property color emberGlow: light ? Qt.darker(accent, 1.35) : warmAccent ? "#F3A66B" : accent
    readonly property color emberHot: warmAccent && !light ? "#F8C894" : Qt.tint(emberCore, Qt.alpha(accent, 0.32))
    readonly property color emberParticle: Qt.tint(emberCore, Qt.alpha(accent, 0.65))
    readonly property color emberTrail: light ? Qt.darker(accent, 1.65) : warmAccent ? "#CC623A" : Qt.darker(accent, 1.25)
    readonly property color fireCore: warmAccent ? "#FFDEA0" : emberCore
    readonly property color fireGold: warmAccent ? "#EEB268" : Qt.lighter(accent, 1.3)
    readonly property color fireHalo: warmAccent ? "#ED641F" : accent
    readonly property color fireLow: warmAccent ? "#B84935" : Qt.darker(accent, 1.7)
    readonly property color fireOrange: warmAccent ? "#EE783C" : accent
    readonly property color glassCoolReflection: light ? "#FFFFFF" : "#C1CBD4"
    readonly property color glassReflection: light ? "#FFFFFF" : "#B6AFAD"
    readonly property color glassSmoke: light ? "#E4E8EE" : "#0B0B0C"
    readonly property color glassTrench: light ? "#53504D" : "#020203"
    readonly property color highlight: light ? "#FFFFFF" : Qt.rgba(1, 1, 1, 0.13)
    readonly property color info: "#7EB0D5"

    // CORE SURFACES
    property bool light: false
    readonly property color materialBottom: light ? "#DEDFE1" : "#080A0C"
    readonly property color materialTop: light ? "#F8F7F4" : "#191B20"
    readonly property color negative: "#E87971"

    // SEMANTIC STATES
    readonly property color positive: "#7CCB91"
    readonly property color rimBottom: light ? "#A5A8AF" : "#30343D"
    readonly property color rimMiddle: light ? "#CACCD1" : "#24262C"

    readonly property color rimTop: light ? "#FFFFFF" : "#55545D"
    readonly property color shadow: Qt.rgba(0, 0, 0, light ? 0.12 : 0.44)
    readonly property color surface: light ? "#F1F0ED" : "#0E1013"
    readonly property color surfaceHover: Qt.alpha(text, 0.07)
    readonly property color surfacePressed: Qt.alpha(text, 0.10)
    readonly property color surfaceRaised: light ? "#FAF9F6" : "#191B20"
    readonly property color surfaceSoft: light ? "#E3E3E1" : "#15171A"

    // TEXT
    readonly property color text: light ? "#24272B" : "#F4F1ED"
    readonly property color textDisabled: Qt.alpha(text, 0.32)
    readonly property color textFaint: light ? "#71747A" : "#716E6A"
    readonly property color textMuted: light ? "#595C62" : "#AAA6A1"
    readonly property color track: Qt.alpha(text, light ? 0.18 : 0.15)

    readonly property bool warmAccent: accent.r > accent.g * 1.15 && accent.g > accent.b * 1.15
    readonly property color warning: "#F2B66D"
    readonly property color wellBottom: light ? "#CDD0D4" : "#101214"
    readonly property color wellTop: light ? "#FFFFFF" : "#292C30"
}
