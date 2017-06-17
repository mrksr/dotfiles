// IMPORTS
const {classes: Cc, interfaces: Ci, utils: Cu} = Components
const nsIStyleSheetService = Cc['@mozilla.org/content/style-sheet-service;1']
    .getService(Ci.nsIStyleSheetService)
const globalMessageManager = Cc['@mozilla.org/globalmessagemanager;1']
    .getService(Ci.nsIMessageListenerManager)
const {Preferences} = Cu.import('resource://gre/modules/Preferences.jsm', {})


// OPTIONS
const MAPPINGS = {
    'element_text_caret': '',
    'follow_next': ']  ä',
    'follow_previous': '[  ö',
    'history_back': 'h',
    'history_forward': 'l',
    'mark_scroll_position': '#',
    'scroll_half_page_down': 'x',
    'scroll_half_page_up': 'X',
    'scroll_left': '<c-h>',
    'scroll_right': '<c-l>',
    'tab_close': 'd',
    'tab_restore': 'u',
    'tab_select_most_recent': 'gl  v',
    'tab_select_next': 'K  gt  ,  L',
    'tab_select_previous': 'J  gT  m  H',
    'go_home': '',
}

const VIMFX_PREFS = {
    'hints.chars': '12345',
    'prev_patterns': v => `vorherige zurück früher  ${v}`,
    'next_patterns': v => `nächste weiter später  ${v}`,
}

const QMARKS = {
    'd': 'http://www.phdcomics.com/comics.php',
    'e': 'https://www.lawblog.de/',
    'f': 'https://blog.fefe.de/',
    'g': 'http://www.zeit.de/index',
    'h': 'http://www.heise.de/',
    'i': 'https://github.com/mrksr',
    'l': 'http://theo.zfix.org/',
    'o': 'http://stackoverflow.com/',
    'p': 'http://forum.mods.de/bb/index.php',
    'q': 'http://questionablecontent.net/',
    'r': 'http://www.reddit.com/',
    's': 'http://spikedmath.com/',
    't': 'http://sc2casts.com/top?month',
    'v': 'http://thedoghousediaries.com/',
    'w': 'https://news.ycombinator.com/news',
    'x': 'https://xkcd.com/',
    'y': 'https://www.youtube.com/feed/subscriptions',
    'z': 'http://www.escapistmagazine.com/videos/view/zero-punctuation',
}

const FIREFOX_PREFS = {
    // 'accessibility.blockautorefresh': true,
    // 'browser.ctrlTab.previews': true,
    // 'browser.fixup.alternate.enabled': false,
    // 'browser.search.suggest.enabled': false,
    // 'browser.startup.page': 3,
    // 'browser.tabs.animate': false,
    // 'browser.tabs.closeWindowWithLastTab': false,
    // 'browser.tabs.warnOnClose': false,
    // 'browser.urlbar.formatting.enabled': false,
    // 'devtools.chrome.enabled': true,
    // 'devtools.command-button-paintflashing.enabled': true,
    // 'devtools.command-button-measure.enabled': true,
    // 'devtools.selfxss.count': 0,
    // 'privacy.donottrackheader.enabled': true,
}


// CUSTOM COMMANDS
const {commands} = vimfx.modes.normal

const CUSTOM_COMMANDS = [
]

// APPLY THE ABOVE
CUSTOM_COMMANDS.forEach(([options, fn]) => {
    vimfx.addCommand(options, fn)
})

Object.entries(MAPPINGS).forEach(([command, value]) => {
    const [shortcuts, mode] = Array.isArray(value)
        ? value
        : [value, 'mode.normal']
    vimfx.set(`${mode}.${command}`, shortcuts)
})

Object.entries(VIMFX_PREFS).forEach(([pref, valueOrFunction]) => {
    const value = typeof valueOrFunction === 'function'
        ? valueOrFunction(vimfx.getDefault(pref))
        : valueOrFunction
    vimfx.set(pref, value)
})

Object.entries(QMARKS).forEach(([key, uri]) => {
    vimfx.addCommand({
        name: `qmark_go${key}`,
        description: `QMark go${key}`,
    }, ({vim}) => {
        vim.window.gBrowser.loadURI(uri)
    })
    vimfx.addCommand({
        name: `qmark_gn${key}`,
        description: `QMark gn${key}`,
    }, ({vim}) => {
        vim.window.gBrowser.loadOneTab(uri, null, null, null, false)
    })
    vimfx.set(`custom.mode.normal.qmark_go${key}`, `go${key}`)
    vimfx.set(`custom.mode.normal.qmark_gn${key}`, `gn${key}`)
})

Preferences.set(FIREFOX_PREFS)
