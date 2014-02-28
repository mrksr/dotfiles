import Control.Monad
import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Util.Run
import XMonad.Util.EZConfig
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
tmuxd = term ++ " -e bash -c \"tmux -q has-session && exec tmux attach-session -d || exec tmux new-session -ndefault -sdefault\""
tmuxc = term ++ " -e zsh -c \"tmux attach -dt \\$(tmux list-sessions | fzf | sed -re 's/^([^:]+).*/\\1/')\""
dmenu = "DMENU_OPTIONS=\"-nb #000 -nf #4d6d99 -sb #333 -sf #cc5214\" dmenu-launch"
mpc   = (++) "mpc -h \"banane@localhost\" "
lock  = "slimlock || gnome-screensaver-command -l"

myWorkspaces =
    ["Stuff", "Browser", "Term", "IM" ,"Mail", "George", "J", "SoilentGreen", "MMXIII"]

myManageHook = composeAll [
      className =? "Pidgin"           --> doShift "IM"
    , className =? "Thunderbird"      --> doShift "Mail"
    , className =? "Firefox"          --> doShift "Browser"
    , className =? "Opera"            --> doShift "Browser"
    , className =? "Chormium-browser" --> doShift "Browser"
    , className =? "Gvim"             --> doShift "Stuff"
    {-, className =? "Smplayer"         --> doFloat-}
    , className =? "Xfce4-notifyd"    --> doIgnore
    , className =? "Gimp-2.8"         --> doShift (myWorkspaces !! 5)
    {-, className =? "Gimp-2.8"         --> doFloat-}
    ]

myKeys = [
    -- M1 ~ Alt
    -- Special Keys
      ("<Print>", spawn "scrot")
    , ("<XF86AudioLowerVolume>", spawn $ "amixer set Master playback 5%-")
    , ("<XF86AudioRaiseVolume>", spawn $ "amixer set Master playback 5%+")
    , ("<XF86AudioPlay>", spawn $ mpc "toggle")
    , ("<XF86AudioStop>", spawn $ mpc "stop")
    , ("<XF86AudioNext>", spawn $ mpc "next")
    , ("<XF86AudioPrev>", spawn $ mpc "prev")
    , ("<XF86Sleep>", spawn "systemctl suspend")
    , ("<XF86ScreenSaver>", spawn lock)
    , ("<XF86TouchpadToggle>", spawn "synclient TouchpadOff=$(synclient -l | grep -ce TouchpadOff.*0)")

    -- Spawns
    , ("M-o", spawn lock)
    , ("M-v", spawn "pavucontrol")
    , ("M-f", spawn "gvim ~/.vimrc ~/.xinitrc ~/.xmonad/xmonad.hs ~/.xmobarrc")
    , ("M-p", spawn "/etc/acpi/actions/docking_station.sh")
    , ("<F12>", spawn dmenu)
    , ("M1-<F12>", spawn "kupfer")
    , ("M-c", spawn term)
    , ("M-x", spawn tmuxd)
    , ("M-y", spawn tmuxc)

    -- Windows
    , ("M1-<F4>", kill)
    , ("M-d", kill)
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
         (modifier, action) <- [("", windows . W.greedyView $ myWorkspaces !! k),
                                ("S-", windows . W.shift $ myWorkspaces !! k)]
    ]

myLayout = onWorkspace "Term" (tabs ||| vs) $
           noBorders full ||| tabs ||| vs ||| hs
    where
    full     = Full
    tabs     = named "Tabs" (tabbedBottom shrinkText tabTheme)
    vs       = named "VS" (ResizableTall masters delta ratio1 [])
    hs       = named "HS" (Mirror (ResizableTall masters delta ratio2 []))
    masters  = 1
    delta    = 2/100
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
    -- Wallpaper
    spawn "nitrogen --restore"
    -- Desktop
    spawnK "trayer" "trayer --edge top --align left --SetDockType true --SetPartialStrut true --expand true --widthtype pixel --width 97 --margin 1823 --transparent true --alpha 0 --tint 0x000000 --height 16"
    -- Arch
    spawnK "wicd-client" "wicd-client -t"
    -- GUIs
    spawn "thunderbird"
    spawn "pidgin"
    spawnOn "Term" term
    windows $ W.view "Term"
    return ()
    where
    -- Fix <M-q>
    spawnK toKill toSpawn = spawn $ "pkill " ++ toKill ++ ";" ++ toSpawn

main = do
    xmproc <- spawnPipe "xmobar"
    -- Jump through hoops for Java GUIs (fix awt)
    conf <- return (
            ewmh defaultConfig {
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
        )
    xmonad conf {
        startupHook = startupHook conf >> setWMName "LG3D"
    }
