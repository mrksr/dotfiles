import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
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

myMod = mod4Mask    -- Super
altMask = mod1Mask  -- Alt
term = "urxvt"

myWorkspaces =
    ["Stuff", "Browser", "Term", "IM" ,"Mail", "MMXIII", "J", "SoilentGreen", "George"]

myManageHook = composeAll [
      className =? "Pidgin" --> doShift "IM"
    , className =? "Thunderbird" --> doShift "Mail"
    , className =? "Firefox" --> doShift "Browser"
    , className =? "Opera" --> doShift "Browser"
    , className =? "Chormium-browser" --> doShift "Browser"
    , className =? "Gvim" --> doShift "Stuff"
    , className =? "Smplayer" --> doFloat
    , className =? "Xfce4-notifyd" --> doIgnore
    , className =? "Gimp-2.8" --> doShift "MMXIII"
    , className =? "Gimp-2.8" --> doFloat
    ]

myKeys = [
        -- Special Keys
          ("<Print>", spawn "scrot")
        , ("<XF86AudioLowerVolume>", lowerVolume 5 >> return () )
        , ("<XF86AudioRaiseVolume>", raiseVolume 5 >> return () )
        , ("<XF86AudioPlay>", spawn "mpc toggle")
        , ("<XF86AudioStop>", spawn "mpc stop")
        , ("<XF86AudioNext>", spawn "mpc next")
        , ("<XF86AudioPrev>", spawn "mpc prev")
        , ("<XF86Sleep>", spawn "sudo pm-suspend")
        , ("<XF86ScreenSaver>", spawn "gnome-screensaver-command -l")

        -- Spawns
        , ("M-o", spawn "gnome-screensaver-command -l")
        , ("M-v", spawn "pavucontrol")
        , ("M-f", spawn "gvim ~/.xmonad/xmonad.hs ~/.xmobarrc ~/.vimrc")
        , ("M-p", spawn dmenu)
        , ("A-<F12>", spawn dmenu)
        , ("<F12>", spawn "kupfer")
        , ("M-d", spawn term)

        -- Windows
        , ("A-<F4>", kill)
        , ("M-c", kill)
        , ("A-<Return>", windows W.shiftMaster)
        , ("A-<Tab>", windows W.focusDown)
        , ("A-S-<Tab>", windows W.focusUp)
        , ("M-g", goToSelected defaultGSConfig)
        , ("M-a", windows copyToAll)
        , ("M-s-a", killAllOtherCopies)

        -- Workspaces
        , ("M-^", toggleWS)
        , ("M-<Tab>", moveTo Next NonEmptyWS)
        , ("M-S-<Tab>", moveTo Prev NonEmptyWS)
        , ("M-s", sendMessage ToggleStruts)
        , ("M-S-h", sendMessage MirrorShrink)
        , ("M-S-l", sendMessage MirrorExpand)
        ]
        where
        dmenu = "dmenu_run -nb '#000000' -nf '#eeeeec' -sb '#14101a'"

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
                  inactiveBorderColor = "#777"
                , activeBorderColor = "#777"
                , activeColor = "#222"
                , inactiveColor = "#000"
                , inactiveTextColor = "aquamarine4"
                , activeTextColor = "aquamarine1"
                , fontName = "xft:Ubuntu Mono-9"
                , decoHeight = 15
                , urgentColor = "#000"
                , urgentTextColor = "#63b8ff"
                }

myStartup = do
    -- Wallpaper
    spawn "nitrogen --restore"
    -- Desktop
    spawn "nautilus --no-desktop -n"
    spawnK "trayer" "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 8 --transparent true --alpha 0 --tint 0x000000 --height 16"
    spawnK "python" "jupiter"
    spawn "dropbox start"
    spawnK "nm-applet" "nm-applet"
    spawn "kupfer"
    spawn "xinput --set-prop \"SynPS/2 Synaptics TouchPad\" \"Device Enabled\" 0"
    -- GUIs
    spawn "thunderbird"
    spawn "pidgin"
    spawnOn "Term" term
    return ()
    where
    -- Fix <S-q>
    spawnK toKill toSpawn = spawn $ "pkill " ++ toKill ++ ";" ++ toSpawn

main = do
  xmproc <- spawnPipe "xmobar"
  xmonad $ defaultConfig {
         borderWidth = 2
       , terminal    = term
       , workspaces  = myWorkspaces
       , modMask     = myMod
       , normalBorderColor = "#252a2b"
       , focusedBorderColor = "#800000"
       , manageHook = manageHook defaultConfig <+> manageSpawn <+> manageDocks <+> myManageHook
       , layoutHook = smartBorders . avoidStruts $ myLayout
       , startupHook = myStartup
       , logHook = dynamicLogWithPP xmobarPP {
                          ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#aaaaaa" "" . shorten 150
                        , ppCurrent = xmobarColor "#eeeeec" ""
                        , ppSep   = " λ "
                        , ppHidden = xmobarColor "#aaaaaa" ""
                        , ppLayout  = xmobarColor "#aaaaaa" ""
                        }
       } `additionalKeysP` myKeys
