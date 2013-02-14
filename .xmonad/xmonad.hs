import XMonad
import qualified XMonad.StackSet as W
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
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
import System.IO
import Graphics.X11.ExtraTypes.XF86

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
      ((0, xK_Print), spawn "scrot")
    , ((0, xF86XK_AudioLowerVolume), lowerVolume 5 >> return () )
    , ((0, xF86XK_AudioRaiseVolume), raiseVolume 5 >> return () )
    , ((0, xF86XK_AudioPlay), spawn "mpc toggle")
    , ((0, xF86XK_AudioStop), spawn "mpc stop")
    , ((0, xF86XK_AudioNext), spawn "mpc next")
    , ((0, xF86XK_AudioPrev), spawn "mpc prev")
    , ((0, xF86XK_Sleep), spawn "sudo pm-suspend")
    , ((0, xF86XK_ScreenSaver), spawn "gnome-screensaver-command -l")

    -- Spawns
    , ((myMod, xK_o), spawn "gnome-screensaver-command -l")
    , ((myMod, xK_p), spawn "dmenu_run -nb '#000000' -nf '#eeeeec' -sb '#14101a'")
    , ((myMod, xK_v), spawn "pavucontrol")
    , ((myMod, xK_f), spawn "gvim ~/.xmonad/xmonad.hs ~/.xmobarrc ~/.vimrc")
    , ((0, xK_F12), spawn "kupfer")
    , ((myMod, xK_d), spawn term)

    -- Windows
    , ((altMask, xK_F4), kill)
    , ((myMod, xK_c), kill)
    , ((altMask, xK_Return), windows W.shiftMaster)
    , ((altMask, xK_Tab), windows W.focusDown)
    , ((altMask .|. shiftMask, xK_Tab), windows W.focusUp)
    , ((myMod, xK_g), goToSelected defaultGSConfig)
    , ((myMod, xK_a), windows copyToAll)
    , ((myMod .|. shiftMask, xK_a), killAllOtherCopies)

    -- Workspaces
    , ((myMod, xK_asciicircum), toggleWS)
    , ((myMod, xK_Tab), moveTo Next NonEmptyWS)
    , ((myMod .|. shiftMask, xK_Tab), moveTo Prev NonEmptyWS)
    , ((myMod, xK_s), sendMessage ToggleStruts)
    , ((myMod .|. shiftMask, xK_h), sendMessage MirrorShrink)
    , ((myMod .|. shiftMask, xK_l), sendMessage MirrorExpand)
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
    spawn "firefox"
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
       } `additionalKeys` myKeys
