import XMonad
import XMonad.Operations
import XMonad.Util.EZConfig
import XMonad.Layout.Gaps
import XMonad.Layout.SimpleFloat
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
-- Layouts
--

--------------------------------------------------------------------------------------------------
-- Conky
--
writeStatus :: String -> IO ()
writeStatus status = writeFile "/home/me/.xmonad/status.conky" status

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
  ((mod1Mask .|. shiftMask, xK_l), spawn "i3lock"),
  ((mod1Mask .|. controlMask, xK_Left), prevWS),
  ((mod1Mask .|. controlMask, xK_Left), prevWS),
  ((mod1Mask .|. controlMask, xK_Right), nextWS),
  ((mod1Mask .|. shiftMask, xK_t), withFocused(float)),
  ((mod1Mask .|. controlMask, xK_End), spawn "/etc/gdm/PostSession/Default; sudo poweroff"),
  ((mod1Mask .|. shiftMask, xK_a), spawn "gnome-terminal"),
  ((mod1Mask, xK_a), withFocused hide),
  ((0, xK_Print), spawn "scrot")
	] ++
    [ ((mod1Mask, k), windows $ SS.greedyView i)
        | (i, k) <- zip myWorkspaces workspaceKeys
    ] ++
	-- Cycle workspaces with keypad [0-9]
	[((m .|. controlMask, k), windows $ f i)
		| (i, k) <- zip myWorkspaces numPadKeys
		, (f, m) <- [(SS.view, 0), (SS.shift, shiftMask)]
	] ++
	-- Cycle workspaces with alternative mod key and regular keyboard numbers
	[((n .|. mod3Mask, l), windows $ x y)
		| (y, l) <- zip myWorkspaces numKeys
		, (x, n) <- [(SS.view, 0), (SS.shift, shiftMask)]
	]
    where workspaceKeys = [xK_F1 .. xK_F11]

numKeys = [xK_0, xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9]

numPadKeys = [ xK_KP_End,  xK_KP_Down,  xK_KP_Page_Down -- 1, 2, 3
             , xK_KP_Left, xK_KP_Begin, xK_KP_Right     -- 4, 5, 6
			, xK_KP_Home, xK_KP_Up,    xK_KP_Page_Up   -- 7, 8, 9
			, xK_KP_Insert] -- 0

-------------------------------------------------------------------------------------------------
-- Hooks
--
myManageHook = composeAll
	[
		resource =? "guake" --> doFloat
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
myWorkspaces = ["[1] vim","[2] g++","[3]","[4]", "[5]","[6]","[7]"]

main = do
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
