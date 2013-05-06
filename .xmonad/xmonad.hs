import Control.Monad
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Actions.Volume
import XMonad.Actions.SpawnOn
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders
import XMonad.Layout.Tabbed
import XMonad.Layout.Named
import XMonad.Layout.ResizableTile

myMod = mod4Mask -- Super
term  = "urxvt"
dmenu = "dmenu_run -i -p 'run' -nb '#000' -nf '#4d6d99' -sb '#333' -sf '#cc5214'"
mpc   = (++) "mpc -h \"banane@localhost\" "

myWorkspaces =
    ["Stuff", "Browser", "Term", "IM" ,"Mail", "George", "J", "SoilentGreen", "MMXIII"]

myManageHook = composeAll [
      className =? "Pidgin"           --> doShift "IM"
    , className =? "Thunderbird"      --> doShift "Mail"
    , className =? "Firefox"          --> doShift "Browser"
    , className =? "Opera"            --> doShift "Browser"
    , className =? "Chormium-browser" --> doShift "Browser"
    , className =? "Gvim"             --> doShift "Stuff"
    , className =? "Smplayer"         --> doFloat
    , className =? "Xfce4-notifyd"    --> doIgnore
    , className =? "Gimp-2.8"         --> doShift (myWorkspaces !! 5)
    , className =? "Gimp-2.8"         --> doFloat
    ]

myKeys = [
    -- M1 ~ Alt
    -- Special Keys
      ("<Print>", spawn "scrot")
    , ("<XF86AudioLowerVolume>", void $ lowerVolume 3)
    , ("<XF86AudioRaiseVolume>", void $ raiseVolume 3)
    , ("<XF86AudioPlay>", spawn $ mpc "toggle")
    , ("<XF86AudioStop>", spawn $ mpc "stop")
    , ("<XF86AudioNext>", spawn $ mpc "next")
    , ("<XF86AudioPrev>", spawn $ mpc "prev")
    , ("<XF86Sleep>", spawn "sudo pm-suspend")
    , ("<XF86ScreenSaver>", spawn "gnome-screensaver-command -l")

    -- Spawns
    , ("M-o", spawn "gnome-screensaver-command -l")
    , ("M-v", spawn "pavucontrol")
    , ("M-f", spawn "gvim ~/.xmonad/xmonad.hs ~/.xmobarrc ~/.vimrc")
    , ("M-p", spawn dmenu)
    , ("<F12>", spawn dmenu)
    , ("M1-<F12>", spawn "kupfer")
    , ("M-d", spawn term)

    -- Windows
    , ("M1-<F4>", kill)
    , ("M-c", kill)
    , ("M1-<Return>", windows W.shiftMaster)
    , ("M1-<Tab>", windows W.focusDown)
    , ("M1-S-<Tab>", windows W.focusUp)
    , ("M-g", goToSelected defaultGSConfig)
    , ("M-a", windows copyToAll)
    , ("M-S-a", killAllOtherCopies)

    -- Workspaces
    , ("M-^", toggleWS)
    , ("M-<Tab>", moveTo Next NonEmptyWS)
    , ("M-S-<Tab>", moveTo Prev NonEmptyWS)
    , ("M-s", sendMessage ToggleStruts)
    , ("M-S-h", sendMessage MirrorShrink)
    , ("M-S-l", sendMessage MirrorExpand)
    ] ++ [
      (modifier ++ "M-<F" ++ show (k - 4) ++ ">" , action) |
                          k <- [4..8],
         (modifier, action) <- [("", windows . W.view $ myWorkspaces !! k),
                                ("S-", windows . W.shift $ myWorkspaces !! k)]
    ]

myLayout = onWorkspace "Term" (tabs ||| vs) $
           Full ||| tabs ||| vs ||| hs
    where
    tabs     = named "Tabs" (tabbedBottom shrinkText tabTheme)
    vs       = named "VS" (ResizableTall masters delta ratio1 [])
    hs       = named "HS" (Mirror (ResizableTall masters delta ratio2 []))
    masters  = 1
    delta    = 3/100
    ratio1   = 21/34
    ratio2   = 23/34
    tabTheme = defaultTheme {
              inactiveBorderColor = "#333"
            , activeBorderColor   = "#333"
            , activeColor         = "#111"
            , inactiveColor       = "#000"
            , inactiveTextColor   = "#4d6d99"
            , activeTextColor     = "#a64211"
            , fontName            = "xft:Ubuntu Mono-9:bold"
            , decoHeight          = 16
            , urgentColor         = "#000"
            , urgentTextColor     = "#638046"
    }

myStartup = do
    windows $ W.view "Term"
    -- Wallpaper
    spawn "nitrogen --restore"
    -- Desktop
    spawn "nautilus --no-desktop -n"
    spawnK "trayer" "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 6 --transparent true --alpha 0 --tint 0x000000 --height 16"
    spawnK "python" "jupiter"
    spawn "dropbox start"
    spawnK "nm-applet" "nm-applet"
    {-spawn "kupfer"-}
    spawn "xinput --set-prop \"SynPS/2 Synaptics TouchPad\" \"Device Enabled\" 0"
    -- GUIs
    spawn "thunderbird"
    spawn "pidgin"
    spawn "mopidy"
    spawnOn "Term" term
    return ()
    where
    -- Fix <M-q>
    spawnK toKill toSpawn = spawn $ "pkill " ++ toKill ++ ";" ++ toSpawn

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ ewmh defaultConfig {
              borderWidth        = 2
            , terminal           = term
            , workspaces         = myWorkspaces
            , modMask            = myMod
            , normalBorderColor  = "#333"
            , focusedBorderColor = "#500000"
            , handleEventHook    = handleEventHook defaultConfig <+> fullscreenEventHook
            , manageHook         = manageHook defaultConfig <+> manageSpawn <+> manageDocks <+> myManageHook
            , layoutHook         = smartBorders . avoidStruts $ myLayout
            , startupHook        = myStartup
            , logHook            = dynamicLogWithPP xmobarPP {
                      ppOutput   = hPutStrLn xmproc
                    , ppTitle    = xmobarColor "#aaaaaa" "" . shorten 150
                    , ppCurrent  = xmobarColor "#eeeeec" ""
                    , ppSep      = " λ "
                    , ppHidden   = xmobarColor "#aaaaaa" ""
                    , ppLayout   = xmobarColor "#aaaaaa" ""
            }
    } `additionalKeysP` myKeys
