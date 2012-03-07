import XMonad
import XMonad.Operations
import XMonad.Util.EZConfig
import XMonad.Layout.Gaps
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Loggers
import XMonad.Prompt
import qualified XMonad.StackSet as SS
import XMonad.Actions.UpdatePointer
import XMonad.Actions.CycleWS
import System.IO
import qualified Data.Map as M
import Data.List

--------------------------------------------------------------------------------------------------
-- Conky
--
writeStatus :: String -> IO ()
writeStatus status = writeFile "/home/mboghiu/.xmonad/status.conky" status

conkyColor :: String -> String -> String
conkyColor color arg = "${color " ++ color ++ "}" ++ arg ++ "${color}"

conkyPP :: String -> PP
conkyPP h = defaultPP {
						ppOutput          = writeStatus,
						ppCurrent         = conkyColor "green",
						ppHiddenNoWindows = conkyColor "grey",
						ppWsSep           = " | ",
						ppSep             = "",
						ppTitle           = const "",
						ppLayout          = const ""
 }

-------------------------------------------------------------------------------------------------
-- Key bindings
--

defKeys = keys defaultConfig
delKeys x = foldr M.delete (defKeys x)(toRemove x)
newKeys x = foldr (uncurry M.insert)(delKeys x)(toAdd x)

-- Remove default key bindings
toRemove x =
	[(modMask x, xK_period),
     (modMask x .|. shiftMask, xK_q)
	]
-- Add my key bindings
toAdd x =
	[
  ((modMask x, xK_s), spawn "firefox"),
  ((mod1Mask , xK_slash), sendMessage (IncMasterN (-1))),
  ((mod1Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock"),
  ((mod1Mask .|. controlMask, xK_Left), prevWS),
  ((mod1Mask .|. controlMask, xK_Left), prevWS),
  ((mod1Mask .|. controlMask, xK_Right), nextWS),
  ((mod1Mask .|. shiftMask, xK_t), withFocused(float)),
  ((mod1Mask .|. controlMask, xK_End), spawn "/etc/gdm/PostSession/Default; sudo poweroff"),
  ((mod1Mask .|. shiftMask, xK_a), spawn "gnome-terminal"),
  ((mod1Mask, xK_a), withFocused hide),
  ((mod1Mask, xK_m), goMail),
  ((0, xK_Print), spawn "scrot")
  --((mod1Mask, xK_h), withFocused hide),
  --((mod1Mask, xK_v), withHidden reveal)
	] ++
	-- Cycle workspaces with keypad [0-9]
	[((m .|. controlMask, k), windows $ f i)
		| (i, k) <- zip myWorkspaces numPadKeys
		, (f, m) <- [(SS.greedyView, 0), (SS.shift, shiftMask)]
	] ++
	-- Cycle workspaces with alternative mod key and regular keyboard numbers
	[((n .|. mod3Mask, l), windows $ x y)
		| (y, l) <- zip myWorkspaces numKeys
		, (x, n) <- [(SS.greedyView, 0), (SS.shift, shiftMask)]
	]
numKeys = [xK_0, xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9]

numPadKeys = [ xK_KP_End,  xK_KP_Down,  xK_KP_Page_Down -- 1, 2, 3
             , xK_KP_Left, xK_KP_Begin, xK_KP_Right     -- 4, 5, 6
			, xK_KP_Home, xK_KP_Up,    xK_KP_Page_Up   -- 7, 8, 9
			, xK_KP_Insert] -- 0

-------------------------------------------------------------------------------------------------
-- Window Handlers
--
handlePidginWindows = do
	doF (SS.shift "[9] Pidgin")

handleFirefoxWindows = do
	doF (SS.shift "[7] Net")

handleThunderbirdWindows = do
	doF (SS.shift "[8] Mail")

handleMuttWindows = do
	doF (SS.shift "[8] Mail")

goMail = do
	windows (SS.view "[8] Mail")
	spawn "rxvt-unicode -e mutt -y"

-------------------------------------------------------------------------------------------------
-- Hooks
--
myManageHook = composeAll
	[
		className =? "OpenOffice.org 3.0"   --> doFloat,
		className =? "Meld"                 --> doFloat,
		className =? "Thunderbird-bin"      --> handleThunderbirdWindows,
		className =? "Firefox"              --> doFloat,
		className =? "Pidgin"               --> handlePidginWindows,
		className =? "Gimp"                 --> doFloat,
		title     =? "POS"                  --> doFloat,
		title     =? "Screens"              --> doFloat,
		title     =? "POS focus handler"    --> doFloat,
		title     =? "POS customer display" --> doFloat,
		title     =? "TBS"                  --> doFloat,
		title     =? "xzgv"                 --> doFloat,
		title     =? "VLC (XVideo output)"  --> doFloat
	]

-------------------------------------------------------------------------------------------------
-- Mouse Bindings
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
	[
		-- ALT-mouse1, Set the window to floating mode and move by dragging
		((modMask, button1), (\w -> focus w >> mouseMoveWindow w)),
		-- ALT-mouse2, Raise the window to the top of the stack
		((modMask, button2), (\w -> focus w >> windows SS.swapMaster)),
		-- ALT-mouse3, Set the window to floating mode and resize by dragging
		((modMask, button3), (\w -> focus w >> mouseResizeWindow w)),
		-- MOUSE CYLCING WORKSPACES
		((modMask, button4), (\w -> focus w >> prevWS)),
		((modMask, button5), (\w -> focus w >> nextWS))
	]
------------------------------------------------------------------------------------------------
-- Main
--
myWorkspaces = ["[1] BUILD DEV","[2] SYS/APP","[3] PJSRC REF","[4] FRONTEND","[5] --","[6] VM","[7] Net","[8] Mail","[9] Pidgin"]
--readWS :: IO [String]
--readWS = do
--t <- readFile "~/.xmonad/conkyWS"
--return (words t)

main = do
	--myWorkspaces <- readWS
    xmonad $
	defaultConfig {
    manageHook         = manageDocks <+> myManageHook <+> manageHook defaultConfig,
    layoutHook         = gaps [(D,25)] $ avoidStruts $ layoutHook defaultConfig,
    logHook            = dynamicLogWithPP $ conkyPP "",
    terminal           = "urxvt",
    keys               = newKeys,
    workspaces         = myWorkspaces,
    mouseBindings      = myMouseBindings,
    focusedBorderColor = "#008E00",
    borderWidth        = 3
	} `additionalKeys` [
		--
		-- KEY BINDINGS
		--
		-- Float window on focus
		((mod1Mask .|. shiftMask, xK_t), withFocused(float)),
		-- End session and turn off
		((mod1Mask .|. controlMask, xK_End), spawn "/etc/gdm/PostSession/Default; sudo poweroff"),
		-- Print Screen; 0 <-- No mod key needed
		((0, xK_Print), spawn "scrot"),
		-- Workspace Cycling
		((mod1Mask .|. controlMask, xK_Left), prevWS),
		((mod1Mask .|. controlMask, xK_Right), nextWS),
		((mod1Mask .|. controlMask, xK_KP_5), moveTo Next (WSIs (return $ not . (=="SP") . SS.tag)))
	]
