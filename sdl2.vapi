[CCode (cprefix="SDL_", cheader_filename="SDL2/SDL.h")]
namespace SDL {

	/**
	 * These flags can be OR'd together.
	 */
	[CCode (cname="int", cprefix="SDL_INIT_", has_type_id=false)]
	[Flags]
	public enum InitFlag {
		/**
		 * timer subsystem
		 */
		TIMER,
		/**
		 * audio subsystem
		 */
		AUDIO,
		/**
		 * video subsystem
		 */
		VIDEO,
		/**
		 * joystick subsystem
		 */
		JOYSTICK,
		/**
		 * haptic (force feedback) subsystem
		 */
		HAPTIC,
		/**
		 * controller subsystem
		 */
		GAMECONTROLLER,
		/**
		 * events subsystem
		 */
		EVENTS,
		/**
		 * all of the above subsystems subsystem
		 */
		EVERYTHING,
		/**
		 * Prevents SDL from catching fatal signals.
		 */
		NOPARACHUTE
	}

	/**
	 * Use this function to initialize the SDL library. This must be called before using any other SDL function.
	 *
	 * The Event Handling, File I/O, and Threading subsystems are initialized by default.
	 * You must specifically initialize other subsystems if you use them in your application.
	 *
	 * If you want to initialize subsystems separately you would call:
	 *
	 * {{{
	 * SDL.init(0);
	 * }}}
	 *
	 * followed by {@link SDL.init_sub_system} with the desired subsystem flag.
	 *
	 * @param flags subsystem initialization flags.
	 *
	 * @return Returns 0 on success or a negative error code on failure; call SDL.get_error() for more information.
	 */
	[CCode (cname="SDL_Init")]
	public static int init(uint32 flags = SDL.InitFlag.EVENTS);

	/**
	 * Use this function to initialize specific SDL subsystems.
	 *
	 * {@link SDL.init} initializes assertions and crash protection and then calls SDL.init_sub_system().
	 * If you want to bypass those protections you can call SDL.init_sub_system() directly.
	 *
	 * Subsystem initialization is ref-counted, you must call {@link SDL.quit_sub_system} for each SDL.init_sub_system()
	 * to correctly shutdown a subsystem manually (or call {@link SDL.quit} to force shutdown).
	 * If a subsystem is already loaded then this call will increase the ref-count and return.
	 *
	 * @param flags any of the flags used by {@link SDL.init}.
	 *
	 * @return Returns 0 on success or a negative error code on failure; call SDL.get_error() for more information.
	 */
	[CCode (cname="SDL_InitSubSystem")]
	public static int init_sub_system(uint32 flags);

	/**
	 * Use this function to clean up all initialized subsystems. You should call it upon all exit conditions.
	 *
	 * You should call this function even if you have already shutdown each initialized subsystem with {@link SDL.quit_sub_system}.
	 * It is safe to call this function even in the case of errors in initialization.
	 *
	 * If you start a subsystem using a call to that subsystem's init function (for example SDL.Video.init())
	 * instead of {@link SDL.init} or {@link SDL.init_sub_system}, then you must use that subsystem's quit function (SDL.Video.quit())
	 * to shut it down before calling SDL.quit().
	 */
	[CCode (cname="SDL_Quit")]
	public static void quit();

	/**
	 * Use this function to shut down specific SDL subsystems.
	 *
	 * @param flags any of the flags used by {@link SDL.init}.
	 */
	[CCode (cname="SDL_Quit")]
	public static void quit_sub_system(uint32 flags);

	/**
	 * Use this function to return a mask of the specified subsystems which have previously been initialized.
	 *
	 * Examples:
	 * {{{
	 * // Get init data on all the subsystems
	 * uint32 subsystemInit = SDL.was_init(SDL.InitFlag.EVERYTHING);
	 * if (subsystemInit & SDL.InitFlag.VIDEO)
	 *   //Video is initalized
	 * }}}
	 * {{{
	 * // Just check for one specific subsystem
	 * if (SDL.was_init(SDL.InitFlag.VIDEO) != 0)
	 *   //Video is initialized
	 * }}}
	 * {{{
	 * // Check for two subsystems
	 * uint32 mask = SDL.InitFlag.VIDEO | SDL.InitFlag.AUDIO;
	 * if (SDL.was_init(mask) == mask)
	 *   //Video and Audio is initialized
	 * }}}
	 *
	 * @param flags any of the flags used by {@link SDL.init}.
	 *
	 * @return If flags is 0 it returns a mask of all initialized subsystems, otherwise it returns the initialization status of the specified subsystems.<<BR>>
	 * The return value does not include {@link SDL.InitFlag.NOPARACHUTE}.
	 */
	[CCode (cname="SDL_WasInit")]
	public static uint32 was_init(uint32 flags);

	/**
	 * Use this function to retrieve a message about the last error that occurred.
	 *
	 * It is possible for multiple errors to occur before calling {@link get_error}.
	 * Only the last error is returned.
	 *
	 * @return Returns a message with information about the specific error that occurred,
	 * or an empty string if there hasn't been an error since the last call to {@link clear_error}.
	 */
	[CCode (cname="SDL_GetError")]
	public static unowned string get_error();

	public class Hints {

		/**
		 * A variable controlling how 3D acceleration is used to accelerate the SDL screen surface.
		 *
		 * SDL can try to accelerate the SDL screen surface by using streaming
		 * textures with a 3D rendering engine. This variable controls whether and
		 * how this is done.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Disable 3D acceleration
		 *  * "1"       - Enable 3D acceleration, using the default renderer.
		 *  * "X"       - Enable 3D acceleration, using X where X is one of the valid rendering drivers. (e.g. "direct3d",  "opengl", etc.)
		 *
		 * By default SDL tries to make a best guess for each platform whether
		 * to use acceleration or not.
		 */
		[CCode (cname="\"SDL_FRAMEBUFFER_ACCELERATION\"")]
		public const string FRAMEBUFFER_ACCELERATION;

		/**
		 * A variable specifying which render driver to use.
		 *
		 * If the application doesn't pick a specific renderer to use, this variable
		 * specifies the name of the preferred renderer.  If the preferred renderer
		 * can't be initialized, the normal default renderer is used.
		 *
		 * This variable is case insensitive and can be set to the following values:
		 *
		 *  * "direct3d"
		 *  * "opengl"
		 *  * "opengles2"
		 *  * "opengles"
		 *  * "software"
		 *
		 * The default varies by platform, but it's the first one in the list that
		 * is available on the current platform.
		 */
		[CCode (cname="\"SDL_RENDER_DRIVER\"")]
		public const string RENDER_DRIVER;

		/**
		 * A variable controlling whether the OpenGL render driver uses shaders if they are available.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Disable shaders
		 *  * "1"       - Enable shaders
		 *
		 * By default shaders are used if OpenGL supports them.
		 */
		[CCode (cname="\"SDL_RENDER_OPENGL_SHADERS\"")]
		public const string RENDER_OPENGL_SHADERS;

		/**
		 * A variable controlling whether the Direct3D device is initialized for thread-safe operations.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Thread-safety is not enabled (faster)
		 *  * "1"       - Thread-safety is enabled
		 *
		 * By default the Direct3D device is created with thread-safety disabled.
		 */
		[CCode (cname="\"SDL_RENDER_DIRECT3D_THREADSAFE\"")]
		public const string RENDER_DIRECT3D_THREADSAFE;

		/**
		 * A variable controlling whether to enable Direct3D 11+'s Debug Layer.
		 *
		 * This variable does not have any effect on the Direct3D 9 based renderer.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Disable Debug Layer use
		 *  * "1"       - Enable Debug Layer use
		 *
		 *  By default, SDL does not use Direct3D Debug Layer.
		 */
		[CCode (cname="\"SDL_HINT_RENDER_DIRECT3D11_DEBUG\"")]
		public const string RENDER_DIRECT3D11_DEBUG;

		/**
		 * A variable controlling the scaling quality
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0" or "nearest" - Nearest pixel sampling
		 *  * "1" or "linear"  - Linear filtering (supported by OpenGL and Direct3D)
		 *  * "2" or "best"    - Currently this is the same as "linear"
		 *
		 * By default nearest pixel sampling is used
		 */
		[CCode (cname="\"SDL_RENDER_SCALE_QUALITY\"")]
		public const string RENDER_SCALE_QUALITY;

		/**
		 * A variable controlling whether updates to the SDL screen surface should be synchronized with the vertical refresh, to avoid tearing.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Disable vsync
		 *  * "1"       - Enable vsync
		 *
		 * By default SDL does not sync screen surface updates with vertical refresh.
		 */
		[CCode (cname="\"SDL_RENDER_VSYNC\"")]
		public const string RENDER_VSYNC;

		/**
		 * A variable controlling whether the screensaver is enabled.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Disable screensaver
		 *  * "1"       - Enable screensaver
		 *
		 * By default SDL will disable the screensaver.
		 */
		[CCode (cname="\"SDL_VIDEO_ALLOW_SCREENSAVER\"")]
		public const string VIDEO_ALLOW_SCREENSAVER;

		/**
		 * A variable controlling whether the X11 VidMode extension should be used.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Disable XVidMode
		 *  * "1"       - Enable XVidMode
		 *
		 * By default SDL will use XVidMode if it is available.
		 */
		[CCode (cname="\"SDL_VIDEO_X11_XVIDMODE\"")]
		public const string VIDEO_X11_XVIDMODE;

		/**
		 * A variable controlling whether the X11 Xinerama extension should be used.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Disable Xinerama
		 *  * "1"       - Enable Xinerama
		 *
		 * By default SDL will use Xinerama if it is available.
		 */
		[CCode (cname="\"SDL_VIDEO_X11_XINERAMA\"")]
		public const string VIDEO_X11_XINERAMA;

		/**
		 * A variable controlling whether the X11 XRandR extension should be used.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Disable XRandR
		 *  * "1"       - Enable XRandR
		 *
		 * By default SDL will not use XRandR because of window manager issues.
		 */
		[CCode (cname="\"SDL_VIDEO_X11_XRANDR\"")]
		public const string VIDEO_X11_XRANDR;

		/**
		 * A variable controlling whether grabbing input grabs the keyboard
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Grab will affect only the mouse
		 *  * "1"       - Grab will affect mouse and keyboard
		 *
		 * By default SDL will not grab the keyboard so system shortcuts still work.
		 */
		[CCode (cname="\"SDL_GRAB_KEYBOARD\"")]
		public const string GRAB_KEYBOARD;

		/**
		 * A variable controlling whether relative mouse mode is implemented using mouse warping
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Relative mouse mode uses raw input
		 *  * "1"       - Relative mouse mode uses mouse warping
		 *
		 * By default SDL will use raw input for relative mouse mode
		 */
		[CCode (cname="\"SDL_MOUSE_RELATIVE_MODE_WARP\"")]
		public const string MOUSE_RELATIVE_MODE_WARP;

		/**
		 * Minimize your SDL_Window if it loses key focus when in fullscreen mode. Defaults to true.
		 */
		[CCode (cname="\"SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS\"")]
		public const string VIDEO_MINIMIZE_ON_FOCUS_LOSS;

		/**
		 * A variable controlling whether the idle timer is disabled on iOS.
		 *
		 * When an iOS app does not receive touches for some time, the screen is
		 * dimmed automatically. For games where the accelerometer is the only input
		 * this is problematic. This functionality can be disabled by setting this
		 * hint.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - Enable idle timer
		 *  * "1"       - Disable idle timer
		 */
		[CCode (cname="\"SDL_IOS_IDLE_TIMER_DISABLED\"")]
		public const string IOS_IDLE_TIMER_DISABLED;

		/**
		 * A variable controlling which orientations are allowed on iOS.
		 *
		 * In some circumstances it is necessary to be able to explicitly control
		 * which UI orientations are allowed.
		 *
		 * This variable is a space delimited list of the following values:
		 *
		 * "LandscapeLeft", "LandscapeRight", "Portrait" "PortraitUpsideDown"
		 */
		[CCode (cname="\"SDL_IOS_ORIENTATIONS\"")]
		public const string IOS_ORIENTATIONS;

		/**
		 * A variable controlling whether an Android built-in accelerometer should be
		 * listed as a joystick device, rather than listing actual joysticks only.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - List only real joysticks and accept input from them
		 *  * "1"       - List real joysticks along with the accelerometer as if it were a 3 axis joystick (the default).
		 */
		[CCode (cname="\"SDL_ACCELEROMETER_AS_JOYSTICK\"")]
		public const string ACCELEROMETER_AS_JOYSTICK;

		/**
		 * A variable that lets you disable the detection and use of Xinput gamepad devices
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"       - Disable XInput detection (only uses direct input)
		 *  * "1"       - Enable XInput detection (the default)
		 */
		[CCode (cname="\"SDL_XINPUT_ENABLED\"")]
		public const string XINPUT_ENABLED;

		/**
		 * A variable that lets you manually hint extra gamecontroller db entries
		 *
		 * The variable should be newline delimited rows of gamecontroller config data, see SDL_gamecontroller.h
		 *
		 * This hint must be set before calling SDL_Init(SDL_INIT_GAMECONTROLLER)
		 * You can update mappings after the system is initialized with SDL_GameControllerMappingForGUID() and SDL_GameControllerAddMapping()
		 */
		[CCode (cname="\"SDL_GAMECONTROLLERCONFIG\"")]
		public const string GAMECONTROLLERCONFIG;

		/**
		 * A variable that lets you enable joystick (and gamecontroller) events even when your app is in the background.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"       - Disable joystick & gamecontroller input events when the
		 *                application is in the background.
		 *  * "1"       - Enable joystick & gamecontroller input events when the
		 *                application is in the background.
		 *
		 * The default value is "0".  This hint may be set at any time.
		 */
		[CCode (cname="\"SDL_JOYSTICK_ALLOW_BACKGROUND_EVENTS\"")]
		public const string JOYSTICK_ALLOW_BACKGROUND_EVENTS;

		/**
		 * If set to 0 then never set the top most bit on a SDL Window, even if the video mode expects it.
		 * This is a debugging aid for developers and not expected to be used by end users. The default is "1"
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "0"       - don't allow topmost
		 *  * "1"       - allow topmost
		 */
		[CCode (cname = "\"SDL_ALLOW_TOPMOST\"")]
		public const string ALLOW_TOPMOST;

		/**
		 * A variable that controls the timer resolution, in milliseconds.
		 *
		 * The higher resolution the timer, the more frequently the CPU services
		 * timer interrupts, and the more precise delays are, but this takes up
		 * power and CPU time. This hint is only used on Windows 7 and earlier.
		 *
		 * See this blog post for more information:
		 * [[http://randomascii.wordpress.com/2013/07/08/windows-timer-resolution-megawatts-wasted/]]
		 *
		 * If this variable is set to "0", the system timer resolution is not set.
		 *
		 * The default value is "1". This hint may be set at any time.
		 */
		[CCode (cname = "\"SDL_TIMER_RESOLUTION\"")]
		public const string TIMER_RESOLUTION;

		/**
		 * If set to 1, then do not allow high-DPI windows. ("Retina" on Mac)
		 */
		[CCode (cname = "\"SDL_VIDEO_HIGHDPI_DISABLED\"")]
		public const string VIDEO_HIGHDPI_DISABLED;

		/**
		 * A variable that determines whether ctrl+click should generate a right-click event on Mac
		 *
		 * If present, holding ctrl while left clicking will generate a right click
		 * event when on Mac.
		 */
		[CCode (cname = "\"SDL_MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK\"")]
		public const string MAC_CTRL_CLICK_EMULATE_RIGHT_CLICK;

		/**
		 * A variable specifying which shader compiler to preload when using the Chrome ANGLE binaries
		 *
		 * SDL has EGL and OpenGL ES2 support on Windows via the ANGLE project. It
		 * can use two different sets of binaries, those compiled by the user from source
		 * or those provided by the Chrome browser. In the later case, these binaries require
		 * that SDL loads a DLL providing the shader compiler.
		 *
		 * This variable can be set to the following values:
		 *
		 *  * "d3dcompiler_46.dll" - default, best for Vista or later.
		 *  * "d3dcompiler_43.dll" - for XP support.
		 *  * "none" - do not load any library, useful if you compiled ANGLE from source and included the compiler in your binaries.
		 */
		[CCode (cname = "\"SDL_VIDEO_WIN_D3DCOMPILER\"")]
		public const string VIDEO_WIN_D3DCOMPILER;

		/**
		 * A variable that is the address of another SDL_Window* (as a hex string formatted with "%p").
		 *
		 * If this hint is set before SDL_CreateWindowFrom() and the SDL_Window* it is set to has
		 * SDL_WINDOW_OPENGL set (and running on WGL only, currently), then two things will occur on the newly
		 * created SDL_Window:
		 *
		 * 1. Its pixel format will be set to the same pixel format as this SDL_Window.  This is
		 * needed for example when sharing an OpenGL context across multiple windows.
		 *
		 * 2. The flag SDL_WINDOW_OPENGL will be set on the new window so it can be used for
		 * OpenGL rendering.
		 *
		 * This variable can be set to the following values:
		 *
		 * The address (as a string "%p") of the SDL_Window* that new windows created with SDL_CreateWindowFrom() should
		 * share a pixel format with.
		 */
		[CCode (cname = "\"SDL_VIDEO_WINDOW_SHARE_PIXEL_FORMAT\"")]
		public const string VIDEO_WINDOW_SHARE_PIXEL_FORMAT;

		/**
		 * A URL to a WinRT app's privacy policy
		 *
		 * All network-enabled WinRT apps must make a privacy policy available to its
		 * users.  On Windows 8, 8.1, and RT, Microsoft mandates that this policy be
		 * be available in the Windows Settings charm, as accessed from within the app.
		 * SDL provides code to add a URL-based link there, which can point to the app's
		 * privacy policy.
		 *
		 * To setup a URL to an app's privacy policy, set SDL_HINT_WINRT_PRIVACY_POLICY_URL
		 * before calling any SDL_Init functions.  The contents of the hint should
		 * be a valid URL.  For example, [["http://www.example.com"]].
		 *
		 * The default value is "", which will prevent SDL from adding a privacy policy
		 * link to the Settings charm.  This hint should only be set during app init.
		 *
		 * The label text of an app's "Privacy Policy" link may be customized via another
		 * hint, SDL_HINT_WINRT_PRIVACY_POLICY_LABEL.
		 *
		 * Please note that on Windows Phone, Microsoft does not provide standard UI
		 * for displaying a privacy policy link, and as such, SDL_HINT_WINRT_PRIVACY_POLICY_URL
		 * will not get used on that platform.  Network-enabled phone apps should display
		 * their privacy policy through some other, in-app means.
		 */
		[CCode (cname = "\"SDL_HINT_WINRT_PRIVACY_POLICY_URL\"")]
		public const string WINRT_PRIVACY_POLICY_URL;

		/**
		 * Label text for a WinRT app's privacy policy link
		 *
		 * Network-enabled WinRT apps must include a privacy policy.  On Windows 8, 8.1, and RT,
		 * Microsoft mandates that this policy be available via the Windows Settings charm.
		 * SDL provides code to add a link there, with it's label text being set via the
		 * optional hint, SDL_HINT_WINRT_PRIVACY_POLICY_LABEL.
		 *
		 * Please note that a privacy policy's contents are not set via this hint.  A separate
		 * hint, SDL_HINT_WINRT_PRIVACY_POLICY_URL, is used to link to the actual text of the
		 * policy.
		 *
		 * The contents of this hint should be encoded as a UTF8 string.
		 *
		 * The default value is "Privacy Policy".  This hint should only be set during app
		 * initialization, preferably before any calls to SDL_Init.
		 *
		 * For additional information on linking to a privacy policy, see the documentation for
		 * SDL_HINT_WINRT_PRIVACY_POLICY_URL.
		 */
		[CCode (cname = "\"SDL_HINT_WINRT_PRIVACY_POLICY_LABEL\"")]
		public const string WINRT_PRIVACY_POLICY_LABEL;

		/**
		 * If set to 1, back button press events on Windows Phone 8+ will be marked as handled.
		 *
		 * TODO, WinRT: document SDL_HINT_WINRT_HANDLE_BACK_BUTTON need and use
		 * For now, more details on why this is needed can be found at the
		 * beginning of the following web page:
		 * [[http://msdn.microsoft.com/en-us/library/windowsphone/develop/jj247550(v=vs.105).aspx]]
		 */
		[CCode (cname = "\"SDL_HINT_WINRT_HANDLE_BACK_BUTTON\"")]
		public const string WINRT_HANDLE_BACK_BUTTON;

		/**
		 * A variable that dictates policy for fullscreen Spaces on Mac OS X.
		 *
		 * This hint only applies to Mac OS X.
		 *
		 * The variable can be set to the following values:
		 *
		 *  * "0"       - Disable Spaces support (FULLSCREEN_DESKTOP won't use them and
		 *                SDL_WINDOW_RESIZABLE windows won't offer the "fullscreen"
		 *                button on their titlebars).
		 *  * "1"       - Enable Spaces support (FULLSCREEN_DESKTOP will use them and
		 *                SDL_WINDOW_RESIZABLE windows will offer the "fullscreen"
		 *                button on their titlebars.
		 *
		 * The default value is "1". Spaces are disabled regardless of this hint if
		 * the OS isn't at least Mac OS X Lion (10.7). This hint must be set before
		 * any windows are created.
		 */
		[CCode (cname = "\"SDL_VIDEO_MAC_FULLSCREEN_SPACES\"")]
		public const string VIDEO_MAC_FULLSCREEN_SPACES;

		/**
		 * Use this function to set a hint with normal priority.
		 *
		 * Hints will not be set if there is an existing override hint or environment
		 * variable that takes precedence. You can use {@link set_hint_with_priority}
		 * to set the hint with override priority instead.
		 *
		 * @param name The hint to set. Use the constans from the {@link Hints} class.
		 * @param hintValue The value of the hint variable.
		 *
		 * @return true if the hint was set. false otherwise.
		 */
		[CCode (cname="SDL_SetHint", cheader_filename="SDL2/SDL_hints.h")]
		public static bool set_hint (string name, string hintValue);
	}

	/**
	 * These define alpha as the opacity of a surface.
	 */
	[CCode (cprefix="SDL_ALPHA_", cheader_filename="SDL2/SDL_pixels.h", has_type_id=false)]
	public enum Alpha {
		OPAQUE,
		TRANSPARENT
	}

	/**
	 * A structure that represents a color.
	 */
	[CCode (cname="SDL_Color", cheader_filename="SDL2/SDL_pixels.h", has_type_id=false)]
	[SimpleType]
	public struct Color {
		/**
		 * The red component in the range 0-255.
		 */
		public uint8 r;

		/**
		 * The green component in the range 0-255.
		 */
		public uint8 g;

		/**
		 * The blue component in the range 0-255.
		 */
		public uint8 b;

		/**
		 * The alpha component in the range 0-255.
		 */
		public uint8 a;
	}

	[CCode (cname="SDL_Palette", cheader_filename="SDL2/SDL_pixels.h", free_function="SDL_FreePalette", has_type_id=false)]
	[Compact]
	public struct Palette {

		/**
		 * An array of Color structures representing the palette.
		 */
		[CCode (array_length_cname="ncolors", array_length_type="int")]
		public Color[] colors;

		/**
		 * Use this function to create a palette structure with the specified number of color entries.
		 *
		 * The palette entries are initialized to white.
		 *
		 * @param ncolors represents the number of color entries in the color palette
		 *
		 * @return Returns a new Palette class on success or null on failure (e.g. if there wasn't enough memory). Call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_AllocPalette")]
		public static Palette? alloc(int ncolors);

		/**
		 * Use this function to set a range of colors in a palette.
		 *
		 * @param colors An array of Color structures to copy into the palette.
		 * @param first_color the index of the first palette entry to modify.
		 */
		[CCode (cname="SDL_SetPaletteColors", array_length_pos=2.1)]
		public int set_colors(Color[] colors, int first_color);
	}

	/**
	 * Everything in the PixelFormat structure is read-only.
	 */
	[CCode (cname="SDL_PixelFormat", cheader_filename="SDL2/SDL_pixels.h", cprefix="SDL_", free_function="SDL_FreeFormat", has_type_id=false)]
	[Compact]
	public class PixelFormat {

		/**
		 * One of the {@link SDL.PixelFormatEnum} values.
		 */
		public PixelFormatEnum format;

		/**
		 * An Palette structure associated with this PixelFormat, or null if the format doesn't have a palette.
		 */
		public Palette palette;

		/**
		 * the number of significant bits in a pixel value, eg: 8, 15, 16, 24, 32.
		 */
		[CCode (cname="BitsPerPixel")]
		public uint8 bits_per_pixel;

		/**
		 * the number of bytes required to hold a pixel value, eg: 1, 2, 3, 4.
		 */
		[CCode (cname="BytesPerPixel")]
		public uint8 bytes_per_pixel;

		/**
		 * A mask representing the location of the red component of the pixel.
		 */
		[CCode (cname="Rmask")]
		public uint32 r_mask;

		/**
		 * A mask representing the location of the greeb component of the pixel.
		 */
		[CCode (cname="Gmask")]
		public uint32 g_mask;

		/**
		 * A mask representing the location of the blue component of the pixel.
		 */
		[CCode (cname="Bmask")]
		public uint32 b_mask;

		/**
		 * A mask representing the location of the alpha component of the pixel
		 * or 0 if the pixel format doesn't have any alpha information.
		 */
		[CCode (cname="Amask")]
		public uint32 a_mask;

		/**
		 * Use this function to map an RGB triple to an opaque pixel value for the this pixel format.
		 *
		 * This function maps the RGB color value to the specified pixel format and returns the pixel value
		 * best approximating the given RGB color value for the given pixel format.
		 * If the format has a palette (8-bit) the index of the closest matching color in the palette will be returned.
		 * If the specified pixel format has an alpha component it will be returned as all 1 bits (fully opaque).
		 * If the pixel format bpp (color depth) is less than 32-bpp then the unused upper bits of the return value
		 * can safely be ignored (e.g., with a 16-bpp format the return value can be assigned to a uint16, and similarly a uint8 for an 8-bpp format).
		 *
		 * @param r the red component of the pixel in the range 0-255.
		 * @param g the green component of the pixel in the range 0-255.
		 * @param b the blue component of the pixel in the range 0-255.
		 *
		 * @return Returns a pixel value;
		 */
		[CCode (cname="SDL_MapRGB")]
		public uint32 map_rgb(uint8 r, uint8 g, uint8 b);
	}

	[CCode (cname="Uint32", cprefix="SDL_PIXELFORMAT_", cheader_filename="SDL2/SDL_pixels.h", has_type_id=false)]
	[Compact]
	public enum PixelFormatEnum {
		UNKNOWN, INDEX1LSB, INDEX1MSB, INDEX4LSB, INDEX4MSB,
		INDEX8, RGB332, RGB444, RGB555, ARGB4444, RGBA4444,
		ABGR4444, BGRA4444, ARGB1555, RGBA5551, ABGR1555,
		BGRA5551, RGB565, BGR565, RGB24, BGR24, RGB888,
		RGBX8888, BGR888, BGRX8888, ARGB8888, RGBA8888,
		ABGR8888, BGRA8888, ARGB2101010,
		/**
		* planar mode: Y + V + U (3 planes)
		*/
		YV12,
		/**
		* planar mode: Y + U + V (3 planes)
		*/
		IYUV,
		/**
		* packed mode: Y0+U0+Y1+V0 (1 plane)
		*/
		YUY2,
		/**
		* packed mode: U0+Y0+V0+Y1 (1 plane)
		*/
		UYVY,
		/**
		* packed mode: Y0+V0+Y1+U0 (1 plane)
		*/
		YVYU
	}

	/**
	 * A structure that defines a rectangle, with the origin at the upper left.
	 */
	[CCode (cheader_filename="SDL2/SDL_rect.h", cname="SDL_Rect", has_type_id=false)]
	public struct Rectangle {

		/**
		 * The x location of the rectangle's upper left corner.
		 */
		public int x;

		/**
		 * The y location of the rectangle's upper left corner.
		 */
		public int y;

		/**
		 * The width of the rectangle.
		 */
		public int w;

		/**
		 * The height of the rectangle.
		 */
		public int h;

	}

	[CCode (cname="SDL_Texture", free_function="SDL_DestroyTexture", cheader_filename="SDL2/SDL_render.h")]
	[Compact]
	public class Texture {
		/**
		 * Create a texture from an existing surface.
		 *
		 * @param renderer The renderer.
		 * @param surface The surface containing pixel data used to fill the texture.
		 *
		 * @return The created texture is returned, or null on error.
		 */
		[CCode (cname="SDL_CreateTextureFromSurface")]
		public static Texture? create_from_surface(Renderer renderer, Surface surface);

		/**
		 * Set an additional color value used in render copy operations.
		 *
		 * @param r The red color value multiplied into copy operations.
		 * @param g The green color value multiplied into copy operations.
		 * @param b TThe blue color value multiplied into copy operations.
		 *
		 * @return 0 on success, or -1 if the texture is not valid or color modulation
		 *          is not supported.
		 */
		[CCode (cname="SDL_SetTextureColorMod")]
		public int set_color_mod(uint8 r, uint8 g, uint8 b);
	}

	[CCode (cprefix="SDL_", cname="SDL_Window", free_function="SDL_DestroyWindow", cheader_filename="SDL2/SDL_video.h", has_type_id=false)]
	[Compact]
	public class Window {

		/**
		 * Used to indicate that you don't care what the window position is.
		 */
		[CCode (cname="SDL_WINDOWPOS_UNDEFINED_MASK")]
		public static const uint8 POS_UNDEFINED;

		/**
		 * Used to indicate that the window position should be centered.
		 */
		[CCode (cname="SDL_WINDOWPOS_CENTERED_MASK")]
		public static const uint8 POS_CENTERED;

		/**
		 * The flags on a window.
		 */
		[CCode (cname="SDL_WindowFlags", cprefix="SDL_WINDOW_", has_type_id=false)]
		[Flags]
		public enum Flags {
			/**
			 * Fullscreen window.
			 */
			FULLSCREEN,
			/**
			 * Window usable with OpenGL context.
			 */
			OPENGL,
			/**
			 * Window is visible.
			 */
			SHOWN,
			/**
			 * Window is not visible.
			 */
			HIDDEN,
			/**
			 * no window decoration.
			 */
			BORDERLESS,
			/**
			 * Window can be resized.
			 */
			RESIZABLE,
			/**
			 * Window is minimized.
			 */
			MINIMIZED,
			/**
			 * Window is maximized.
			 */
			MAXIMIZED,
			/**
			 * Window has grabbed input focus.
			 */
			INPUT_GRABBED,
			/**
			 * Window has input focus.
			 */
			INPUT_FOCUS,
			/**
			 * Window has mouse focus.
			 */
			MOUSE_FOCUS,
			/**
			 * Fullscreen window at the current desktop resolution.
			 */
			FULLSCREEN_DESKTOP,
			/**
			 * Window not created by SDL.
			 */
			FOREIGN,
			/**
			 * Window should be created in high-DPI mode if supported (>= SDL 2.0.1).
			 */
			ALLOW_HIGHDPI
		}

		/**
		 * Use this function to create a window with the specified position, dimensions, and flags.
		 *
		 * @param title the title of the window.
		 * @param x the x position of the window, {@link SDL.Window.POS_CENTERED} or {@link SDL.Window.POS_UNDEFINED}.
		 * @param y the y position of the window, {@link SDL.Window.POS_CENTERED} or {@link SDL.Window.POS_UNDEFINED}.
		 * @param w the width of the window.
		 * @param h the height of the window.
		 * @param flags 0, or one or more of the following {@link SDL.Window.Flags} OR'd together:
		 * FULLSCREEN
		 * ,FULLSCREEN_DESKTOP
		 * ,OPENGL
		 * ,HIDDEN
		 * ,BORDERLESS
		 * ,RESIZABLE
		 * ,MINIMIZED
		 * ,MAXIMIZED
		 * ,INPUT_GRABBED
		 * ,ALLOW_HIGHDPI
		 *
		 * @return Returns the window that was created or null on failure; call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_CreateWindow")]
		public static Window? create(string title, int x, int y, int w, int h, uint32 flags);

		/**
		 * Use this function to get the size of a window's client area.
		 *
		 * null can safely be passed as the w or h parameter if the width or height value is not desired.
		 *
		 * @param w will be filled with the width of the window.
		 * @param h will be filled with the height of the window.
		 */
		[CCode (cname="SDL_GetWindowSize")]
		public void get_size(out int w, out int h);

		/**
		 * Use this function to get the {@link SDL.Surface} associated with the window.
		 *
		 * @return Returns the surface associated with the window, or null on failure; call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_GetWindowSurface")]
		public unowned Surface? get_surface();

		/**
		 * Use this function to copy the window surface to the screen.
		 *
		 * @return Returns 0 on success or a negative error code on failure; call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_UpdateWindowSurface")]
		public int update_surface();
	}

	[CCode (cprefix="SDL_", cname="SDL_Renderer", free_function="SDL_DestroyRenderer", cheader_filename="SDL2/SDL_render.h", has_type_id=false)]
	[Compact]
	public class Renderer {

		/**
		 * Flags used when creating a rendering context.
		 */
		[CCode (cname="SDL_RenderFlags", cprefix="SDL_RENDERER_", has_type_id=false)]
		public enum Flags {
			/**
			 * The renderer is a software fallback.
			 */
			SOFTWARE,
			/**
			 * The renderer uses hardware acceleration.
			 */
			ACCELERATED,
			/**
			 * Present is synchronized with the refresh rate.
			 */
			PRESENTVSYNC,
			/**
			 * The renderer supports rendering to texture.
			 */
			TARGETTEXTURE
		}

		/**
		 * Use this function to create a 2D rendering context for a window.
		 *
		 * Note that providing no flags gives priority to available {@link SDL.Renderer.Flags.ACCELERATED} renderers.
		 *
		 * @param window the window where rendering is displayed
		 * @param index the index of the rendering driver to initialize, or -1 to initialize the first one supporting the requested flags.
		 * @param flags 0, or one or more {@link SDL.Renderer.Flags} OR'd together.
		 *
		 * @return Returns a valid rendering context or null if there was an error. Call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_CreateRenderer")]
		public static Renderer? create_renderer(Window window, int index, uint32 flags);

		/**
		 * Use this function to clear the current rendering target with the drawing color.
		 *
		 * @return Returns 0 on success or a negative error code on failure; call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_RenderClear")]
		public int clear();


		/**
		 * Copy a portion of the texture to the current rendering target.
		 *
		 * @param texture The source texture.
		 * @param srcrect The source rectangle, or null for the entire texture.
		 * @param dstrect The destination rectangle, or null for the entire rendering target. The texture will be stretched to fill the given rectangle.
		 *
		 * @return 0 on success, or -1 on error.
		 */
		[CCode (cname="SDL_RenderCopy")]
		public int copy(Texture texture, Rectangle? srcrect, Rectangle? dstrect);

		/**
		 * Draw a line on the current rendering target.
		 *
		 * @param x1 The x coordinate of the start point.
		 * @param y1 The y coordinate of the start point.
		 * @param x2 The x coordinate of the end point.
		 * @param y2 The y coordinate of the end point.
		 *
		 * @return 0 on success, or -1 on error.
		 */
		[CCode (cname="SDL_RenderDrawLine")]
		public int draw_line(int x1, int y1, int x2, int y2);

		/**
		 * Draw a point on the current rendering target.
		 *
		 * @param x The x coordinate of the point.
		 * @param y The y coordinate of the point.
		 *
		 * @return 0 on success, or -1 on error.
		 */
		[CCode (cname="SDL_RenderDrawPoint")]
		public int draw_point(int x, int y);

		/**
		 * Draw a rectangle on the current rendering target.
		 *
		 * @param rect The destination rectangle, or null to outline the entire rendering target.
		 *
		 * @return 0 on success, or -1 on error.
		 */
		[CCode (cname="SDL_RenderDrawRect")]
		public int draw_rect(Rectangle rect);

		/**
		 * Fill a rectangle on the current rendering target with the drawing color.
		 *
		 * @param rect The destination rectangle, or null for the entire rendering target.
		 *
		 * @return 0 on success, or -1 on error.
		 */
		[CCode (cname="SDL_RenderFillRect")]
		public int fill_rect(Rectangle rect);

		/**
		 * Use this function to update the screen with any rendering performed since the previous call.
		 */
		[CCode (cname="SDL_RenderPresent")]
		public void present();

		/**
		 * Use this function to set the color used for drawing operations (Rectangle, Line and Clear).
		 *
		 * @param r The Red value used to draw on the rendering target.
		 * @param g The Green value used to draw on the rendering target.
		 * @param b The Blue value used to draw on the rendering target.
		 * @param a The alpha value used to draw on the rendering target. Usually {@link SDL.Alpha.OPAQUE} (255).
		 *          Use set_draw_blend_mode() to specify how the alpha channel is used
		 *
		 * @return Returns 0 on success or a negative error code on failure; call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_SetRenderDrawColor")]
		public int set_draw_color(uint8 r, uint8 g, uint8 b, uint8 a);

		/**
		 * Set the drawing area for rendering on the current target.
		 *
		 * If the window associated with the renderer is resized, the viewport is automatically reset.
		 *
		 * @param rect The rectangle representing the drawing area, or null to set the viewport to the entire target.
		 *             The x,y of the viewport rect represents the origin for rendering.
		 *
		 * @return 0 on success, or -1 on error.
		 */
		[CCode (cname="SDL_RenderSetViewport")]
		public int set_viewport(Rectangle rect);
	}

	[CCode (cname="SDL_TimerID", ref_function="", unref_function="", cheader_filename="SDL2/SDL_timer.h", has_type_id=false)]
	[Compact]
	public class Timer {

		/**
		 * Use this function to wait a specified number of milliseconds before returning.
		 *
		 * It waits at least the specified time, but possibly longer due to OS scheduling.
		 *
		 * @param ms The number of milliseconds to delay.
		 */
		[CCode (cname="SDL_Delay")]
		public static void delay(uint32 ms);
	}

	/**
	 * A collection of pixels used in software blitting.
	 *
	 * This class should be treated as read-only, except for the pixels attribute,
	 * which, if not null, contains the raw pixel data for the surface.
	 */
	[CCode (cname="SDL_Surface", ref_function="", unref_function="SDL_FreeSurface", cheader_filename="SDL2/SDL_surface.h", has_type_id=false)]
	[Compact]
	public class Surface {

		/**
		 * The format of the pixels stored in the surface. (read-only)
		 */
		public PixelFormat format;

		/**
		 * The width in pixels. (read-only)
		 */
		public int w;

		/**
		 * The height in pixels. (read-only)
		 */
		public int h;

		/**
		 * The lenght of a row of pixels in bytes. (read-only)
		 */
		public int pitch;

		/**
		 * The pointer to the actual pixel data. (read-write)
		 *
		 * With most surfaces you can access the pixels directly. Surfaces that have been optimized with
		 * set_rle() should be locked with lock() before accessing pixels. When you are done you should call
		 * unlock() before blitting.
		 */
		public void* pixels;

		/**
		 * An arbitrary pointer you can set. (read-write)
		 */
		public void *userdata;

		/**
		 * An Rectangle used to clip blits to the surface which can be set by set_clip_rect() (read-only)
		 */
		public Rectangle clip_rect;

		/**
		 * Reference count that can be incremented by the application.
		 */
		[CCode (cname="refcount")]
		public int ref_count;

		/**
		 * Obtain a new Reference.
		 */
		public Surface @ref() {
			GLib.AtomicInt.inc(ref ref_count);
			return this;
		}

		/**
		 * Use this function to load a surface from a BMP file.
		 *
		 * @param file The file containing an BMP image.
		 *
		 * @return Returns a new Surface or null if there was an error. Call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_LoadBMP")]
		public static Surface? load_bmp(string file);

		/**
		 * This performs a fast blit from the source surface to the destination surface.
		 *
		 * Only the position is used in the dstrect (the width and height are ignored).
		 *
		 * If either srcrect or dstrect are null, the entire surface is copied.
		 *
		 * The final blit rectangle is saved in dstrect after all clipping is performed (srcrect is not modified).
		 *
		 * The blit function should not be called on a locked surface.
		 *
		 * The  results of blitting operations vary greatly depending on whether SDL_SRCAPLHA is set or not. See SDL.SetAlpha for
		 * an explaination of how this affects your results. Colorkeying and alpha attributes also interact with surface blitting,
		 * as the following pseudo-code should hopefully explain.
		 * {{{
		 * if (source surface has SDL_SRCALPHA set) {
		 *    if (source surface has alpha channel (that is, format->Amask != 0))
		 *       blit using per-pixel alpha, ignoring any colour key
		 *    else {
		 *       if (source surface has SDL_SRCCOLORKEY set)
		 *          blit using the colour key AND the per-surface alpha value
		 *       else
		 *          blit using the per-surface alpha value
		 *    }
		 * } else {
		 *    if (source surface has SDL_SRCCOLORKEY set)
		 *       blit using the colour key
		 *    else
		 *       ordinary opaque rectangular blit
		 * }
		 * }}}
		 *
		 * @param srcrect The {@link Rectangle} representing the rectangle to be copied, or null to copy the entire surface.
		 * @param dst The {@link Surface} that is the blit target.
		 * @param dstrect The {@link Rectangle} representing the the rectangle that is copied into.
		 *
		 * @return If the blit is successful, it returns 0, otherwise it returns -1.
		 * If either of the surfaces were in video memory, and the blit returns -2, the video memory was lost, so it should be reloaded with artwork and re-blitted:
		 * {{{
		 * while ( SDL_BlitSurface(image, imgrect, screen, dstrect) == -2 ) {
		 *    while ( SDL_LockSurface(image)) < 0 )
		 *       Sleep(10);
		 *    -- Write image pixels to image->pixels --
		 *    SDL_UnlockSurface(image);
		 * }
		 * }}}
		 * This happens under DirectX 5.0 when the system switches away from your fullscreen application. Locking the surface
		 * will also fail until you  have  access  to  the  video  memory again.
		 */
		[CCode (cname="SDL_BlitSurface", cheader_filename="SDL2/SDL.h")]
		public int blit(Rectangle? srcrect, Surface dst, Rectangle? dstrect);

		/**
		 * Use this function to perform a scaled surface copy to a destination surface.
		 *
		 * @param srcrect The {@link Rectangle} representing the rectangle to be copied, or null to copy the entire surface.
		 * @param dst The Surface that is the blit target.
		 * @param dstrect The {@link Rectangle} representing the rectangle that is copied into, or null to copy into the entire surface.
		 *
		 * @return 0 on success or a negative error code on failure; call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_BlitScaled")]
		public int blit_scaled(Rectangle? srcrect, Surface dst, Rectangle? dstrect);

		/**
		 * Use this function to copy an existing {@link Surface} into a new one that is optimized for blitting to a surface of a specified {@link PixelFormat}.
		 *
		 * This function is used to optimize images for faster repeat blitting. This is accomplished by converting the original
		 * and storing the result as a new surface. The new, optimized surface can then be used as the source for future blits, making them faster.
		 *
		 * @param fmt The pixel format that the new surface is optimized for.
		 * @param flags = The flags are unused and should be set to 0. This is a leftover from SDL 1.2's API.
		 *
		 * @return Returns the new Surface that is created or null if it fails. Call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_ConvertSurface", cheader_filename="SDL/SDL.h")]
		public Surface? convert(PixelFormat fmt, uint32 flags = 0);

		/**
		 * Use this function to perform a fast fill of a rectangle with a specific color.
		 *
		 * The Color üarameter should be a pixel of the format used by the surface, and can be generated by SDL.map_RGB() or SDL.map_RGBA().
		 * If the color value contains an alpha component then the destination is simply filled with that alpha information, no blending takes place.
		 * If there is a clip rectangle set on the destination (set via set_clip_rect()), then this function will fill based on the intersection
		 * of the clip rectangle and the rect parameter.
		 *
		 * @param rect The structure representing the rectangle to fill, or null to fill the entire surface.
		 * @param color The color to fill with.
		 *
		 * @return Returns 0 on success or a negative error code on failure; call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_FillRect")]
		public int fill_rect(Rectangle? rect, uint32 color);

		/**
		 * Sets the color key (transparent pixel) in a blittable surface.
		 *
		 * @param flag enable or disable color key.
		 * @param key The transparent pixel in the native surface format.
		 *
		 * @return 0 on success, or -1 if the surface is not valid.
		 */
		[CCode (cname="SDL_SetColorKey")]
		public int set_colorkey(bool flag, uint32 key);
	}

	[CCode (cname="SDL_EventType", cprefix="SDL_", cheader_filename="SDL2/SDL_events.h")]
	public enum EventType {
		/**
		 * User-requested quit
		 */
		QUIT,
		/**
		 * The application is being terminated by the OS.
		 * Called on iOS in applicationWillTerminate().
		 * Called on Android in onDestroy().
		 */
		APP_TERMINATING,
		/**
		 * The application is low on memory, free memory if possible.
		 * Called on iOS in applicationDidReceiveMemoryWarning().
		 * Called on Android in onLowMemory().
		 */
		APP_LOWMEMORY,
		/**
		 * The application is about to enter the background
		 * Called on iOS in applicationWillResignActive()
		 * Called on Android in onPause()
		 */
		APP_WILLENTERBACKGROUND,
		/**
		 * The application did enter the background and may not get CPU for some time
		 * Called on iOS in applicationDidEnterBackground()
		 * Called on Android in onPause()
		 */
		APP_DIDENTERBACKGROUND,
		/**
		 * The application is about to enter the foreground
		 * Called on iOS in applicationWillEnterForeground()
		 * Called on Android in onResume()
		 */
		APP_WILLENTERFOREGROUND,
		/**
		 * The application is now interactive
		 * Called on iOS in applicationDidBecomeActive()
		 * Called on Android in onResume()
		 */
		APP_DIDENTERFOREGROUND,
		/**
		 * Window state change
		 */
		WINDOWEVENT,
		/**
		 * System specific event
		 */
		SYSWMEVENT,
		/**
		 * Key pressed
		 */
		KEYDOWN,
		/**
		 * Key released
		 */
		KEYUP,
		/**
		 * Keyboard text editing (composition)
		 */
		TEXTEDITING,
		/**
		 * Keyboard text input
		 */
		TEXTINPUT,
		/**
		 * Mouse moved
		 */
		MOUSEMOTION,
		/**
		 * Mouse button pressed
		 */
		MOUSEBUTTONDOWN,
		/**
		 * Mouse button released
		 */
		MOUSEBUTTONUP,
		/**
		 * Mouse wheel motion
		 */
		MOUSEWHEEL,
		/**
		 * Joystick axis motion
		 */
		JOYAXISMOTION,
		/**
		 * Joystick trackball motion
		 */
		JOYBALLMOTION,
		/**
		 * Joystick hat position change
		 */
		JOYHATMOTION,
		/**
		 * Joystick button pressed
		 */
		JOYBUTTONDOWN,
		/**
		 * A new joystick has been inserted into the system
		 */
		JOYDEVICEADDED,
		/**
		 * An opened joystick has been removed
		 */
		JOYDEVICEREMOVED,
		/**
		 * Game controller axis motion
		 */
		CONTROLLERAXISMOTION,
		/**
		 * Game controller button pressed
		 */
		CONTROLLERBUTTONDOWN,
		/**
		 * Game controller button released
		 */
		SDL_CONTROLLERBUTTONUP,
		/**
		 * A new Game controller has been inserted into the system
		 */
		CONTROLLERDEVICEADDED,
		/**
		 * An opened Game controller has been removed
		 */
		CONTROLLERDEVICEREMOVED,
		/**
		 * The controller mapping was updated
		 */
		CONTROLLERDEVICEREMAPPED,
		FINGERDOWN, FINGERUP, FINGERMOTION, DOLLARGESTURE, DOLLARRECORD, MULTIGESTURE,
		/**
		 * The clipboard changed
		 */
		CLIPBOARDUPDATE,
		/**
		 * The system requests a file open
		 */
		DROPFILE,
		/**
		 * The render targets have been reset
		 */
		RENDER_TARGETS_RESET;
	}

	/**
	 * General keyboard/mouse state definitions.
	 */
	[CCode (cname="Uint8", cprefix="SDL_", cheader_filename="SDL2/SDL_events.h", has_type_id=false)]
	public enum EventState {
		PRESSED,
		RELEASED;
	}

	/**
	 * An enumeration of key modifier masks.
	 */
	[CCode (cname="Uint16", cprefix="SDL_KMOD_", cheader_filename="SDL2/SDL_keyboard.h", has_type_id=false)]
	public enum Keymod {
		/**
		 * 0 (no modifier is applicable)
		 */
		NONE,
		/**
		 * The left Shift key is down.
		 */
		LSHIFT,
		/**
		 * The right Shift key is down.
		 */
		RSHIFT,
		/**
		 * The left Ctrl (Control) key is down.
		 */
		LCTRL,
		/**
		 * The right Ctrl (Control) key is down.
		 */
		RCTRL,
		/**
		 * The left Alt key is down.
		 */
		LALT,
		/**
		 * The right Alt key is down.
		 */
		RALT,
		/**
		 * The left meta key (often Windows key) is down.
		 */
		LMETA,
		/**
		 * The right meta key (often Windows key) is down.
		 */
		RMETA,
		/**
		 * The Num Lock key (may be located on an extended keypad) is down.
		 */
		NUM,
		/**
		 * The Caps Lock key is down.
		 */
		CAPS,
		/**
		 * The AltGr key is down.
		 */
		MODE,
		/**
		 * (LCTRL|RCTRL)
		 */
		CTRL,
		/**
		 * (LSHIFT|RSHIFT)
		 */
		SHIFT,
		/**
		 * (LALT|RALT)
		 */
		ALT,
		/**
		 * (LMETA|RMETA)
		 */
		META;
	}

	/**
	 * The SDL keyboard scancode representation.
	 *
	 * Values of this type are used to represent keyboard keys, among other places
	 * in the {@link SDL.Keysym.scancode} field of the {@link SDL.KeyboardEvent}
	 *
	 * The values in this enumeration are based on the USB usage page standard:
	 * [[http://www.usb.org/developers/devclass_docs/Hut1_12v2.pdf]]
	 */
	[CCode (cname="SDL_Scancode", cprefix="SDK_SCANCODE_", cheader_filename="SDL2/SDL_scancode.h", has_type_id=false)]
	public enum Scancode { //TODO documentation
		UNKNOWN,
		A,
		B,
		C,
		D,
		E,
		F,
		G,
		H,
		I,
		J,
		K,
		L,
		M,
		N,
		O,
		P,
		Q,
		R,
		S,
		T,
		U,
		V,
		W,
		X,
		Y,
		Z,
		[CCode (cname="SDL_SCANCODE_1")]
		ONE,
		[CCode (cname="SDL_SCANCODE_2")]
		TWO,
		[CCode (cname="SDL_SCANCODE_3")]
		THREE,
		[CCode (cname="SDL_SCANCODE_4")]
		FOUR,
		[CCode (cname="SDL_SCANCODE_5")]
		FIVE,
		[CCode (cname="SDL_SCANCODE_6")]
		SIX,
		[CCode (cname="SDL_SCANCODE_7")]
		SVEN,
		[CCode (cname="SDL_SCANCODE_8")]
		EIGHT,
		[CCode (cname="SDL_SCANCODE_9")]
		NINE,
		[CCode (cname="SDL_SCANCODE_0")]
		ZERO,
		RETURN,
		ESCAPE,
		BACKSPACE,
		TAB,
		SPACE,
		MINUS,
		EQUALS,
		LEFTBRACKET,
		RIGHTBRACKET,
		BACKSLASH,
		NONUSHASH,
		SEMICOLON,
		APOSTROPHE,
		GRAVE,
		COMMA,
		PERIOD,
		SLASH,
		CAPSLOCK,
		F1,
		F2,
		F3,
		F4,
		F5,
		F6,
		F7,
		F8,
		F9,
		F10,
		F11,
		F12,
		PRINTSCREEN,
		SCROLLLOCK,
		PAUSE,
		INSERT,
		HOME,
		PAGEUP,
		DELETE,
		END,
		PAGEDOWN,
		RIGHT,
		LEFT,
		DOWN,
		UP,
		NUMLOCKCLEAR,
		KP_DIVIDE,
		KP_MULTIPLY,
		KP_MINUS,
		KP_PLUS,
		KP_ENTER,
		KP_1,
		KP_2,
		KP_3,
		KP_4,
		KP_5,
		KP_6,
		KP_7,
		KP_8,
		KP_9,
		KP_0,
		KP_PERIOD,
		NONUSBACKSLASH,
		APPLICATION,
		POWER,
		KP_EQUALS,
		F13,
		F14,
		F15,
		F16,
		F17,
		F18,
		F19,
		F20,
		F21,
		F22,
		F23,
		F24,
		EXECUTE,
		HELP,
		MENU,
		SELECT,
		STOP,
		AGAIN,
		UNDO,
		CUT,
		COPY,
		PASTE,
		FIND,
		MUTE,
		VOLUMEUP,
		VOLUMEDOWN,
		KP_COMMA,
		KP_EQUALSAS400,
		INTERNATIONAL1,
		INTERNATIONAL2,
		INTERNATIONAL3,
		INTERNATIONAL4,
		INTERNATIONAL5,
		INTERNATIONAL6,
		INTERNATIONAL7,
		INTERNATIONAL8,
		INTERNATIONAL9,
		LANG1,
		LANG2,
		LANG3,
		LANG4,
		LANG5,
		LANG6,
		LANG7,
		LANG8,
		LANG9,
		ALTERASE,
		SYSREQ,
		CANCEL,
		CLEAR,
		PRIOR,
		RETURN2,
		SEPARATOR,
		OUT,
		OPER,
		CLEARAGAIN,
		CRSEL,
		EXSEL,
		KP_00,
		KP_000,
		THOUSANDSSEPARATOR,
		DECIMALSEPARATOR,
		CURRENCYUNIT,
		CURRENCYSUBUNIT,
		KP_LEFTPAREN,
		KP_RIGHTPAREN,
		KP_LEFTBRACE,
		KP_RIGHTBRACE,
		KP_TAB,
		KP_BACKSPACE,
		KP_A,
		KP_B,
		KP_C,
		KP_D,
		KP_E,
		KP_F,
		KP_XOR,
		KP_POWER,
		KP_PERCENT,
		KP_LESS,
		KP_GREATER,
		KP_AMPERSAND,
		KP_DBLAMPERSAND,
		KP_VERTICALBAR,
		KP_DBLVERTICALBAR,
		KP_COLON,
		KP_HASH,
		KP_SPACE,
		KP_AT,
		KP_EXCLAM,
		KP_MEMSTORE,
		KP_MEMRECALL,
		KP_MEMCLEAR,
		KP_MEMADD,
		KP_MEMSUBTRACT,
		KP_MEMMULTIPLY,
		KP_MEMDIVIDE,
		KP_PLUSMINUS,
		KP_CLEAR,
		KP_CLEARENTRY,
		KP_BINARY,
		KP_OCTAL,
		KP_DECIMAL,
		KP_HEXADECIMAL,
		LCTRL,
		LSHIFT,
		LALT,
		LGUI,
		RCTRL,
		RSHIFT,
		RALT,
		RGUI,
		MODE,
		AUDIONEXT,
		AUDIOPREV,
		AUDIOSTOP,
		AUDIOPLAY,
		AUDIOMUTE,
		MEDIASELECT,
		WWW,
		MAIL,
		CALCULATOR,
		COMPUTER,
		AC_SEARCH,
		AC_HOME,
		AC_BACK,
		AC_FORWARD,
		AC_STOP,
		AC_REFRESH,
		AC_BOOKMARKS,
		BRIGHTNESSDOWN,
		BRIGHTNESSUP,
		DISPLAYSWITCH,
		KBDILLUMTOGGLE,
		KBDILLUMDOWN,
		KBDILLUMUP,
		EJECT,
		SLEEP,
		APP1,
		APP2;
	}

	[CCode (cname="SDL_Keycode", cprefix="SDLK_", cheader_filename="SDL2/SDL_keycode.h", has_type_id=false)]
	public enum Keycode {
		UNKNOWN,
		RETURN,
		ESCAPE,
		BACKSPACE,
		TAB,
		SPACE,
		EXCLAIM,
		QUOTEDBL,
		HASH,
		PERCENT,
		DOLLAR,
		AMPERSAND,
		QUOTE,
		LEFTPAREN,
		RIGHTPAREN,
		ASTERISK,
		PLUS,
		COMMA,
		MINUS,
		PERIOD,
		SLASH,
		[CCode (cname="SDLK_0")]
		ZERO,
		[CCode (cname="SDLK_1")]
		ONE,
		[CCode (cname="SDLK_2")]
		TWO,
		[CCode (cname="SDLK_3")]
		THREE,
		[CCode (cname="SDLK_4")]
		FOUR,
		[CCode (cname="SDLK_5")]
		FIVE,
		[CCode (cname="SDLK_6")]
		SIX,
		[CCode (cname="SDLK_7")]
		SEVEN,
		[CCode (cname="SDLK_8")]
		EIGHT,
		[CCode (cname="SDLK_9")]
		NINE,
		COLON,
		SEMICOLON,
		LESS,
		EQUALS,
		GREATER,
		QUESTION,
		AT,
		LEFTBRACKET,
		BACKSLASH,
		RIGHTBRACKET,
		CARET,
		UNDERSCORE,
		BACKQUOTE,
		[CCode (cname="SDLK_a")]
		A,
		[CCode (cname="SDLK_b")]
		B,
		[CCode (cname="SDLK_c")]
		C,
		[CCode (cname="SDLK_d")]
		D,
		[CCode (cname="SDLK_e")]
		E,
		[CCode (cname="SDLK_f")]
		F,
		[CCode (cname="SDLK_g")]
		G,
		[CCode (cname="SDLK_h")]
		H,
		[CCode (cname="SDLK_i")]
		I,
		[CCode (cname="SDLK_j")]
		J,
		[CCode (cname="SDLK_k")]
		K,
		[CCode (cname="SDLK_l")]
		L,
		[CCode (cname="SDLK_m")]
		M,
		[CCode (cname="SDLK_n")]
		N,
		[CCode (cname="SDLK_o")]
		O,
		[CCode (cname="SDLK_p")]
		P,
		[CCode (cname="SDLK_q")]
		Q,
		[CCode (cname="SDLK_r")]
		R,
		[CCode (cname="SDLK_s")]
		S,
		[CCode (cname="SDLK_t")]
		T,
		[CCode (cname="SDLK_o")]
		U,
		[CCode (cname="SDLK_v")]
		V,
		[CCode (cname="SDLK_w")]
		W,
		[CCode (cname="SDLK_x")]
		X,
		[CCode (cname="SDLK_y")]
		Y,
		[CCode (cname="SDLK_z")]
		Z,
		CAPSLOCK,
		F1,
		F2,
		F3,
		F4,
		F5,
		F6,
		F7,
		F8,
		F9,
		F10,
		F11,
		F12,
		PRINTSCREEN,
		SCROLLLOCK,
		PAUSE,
		INSERT,
		HOME,
		PAGEUP,
		DELETE,
		END,
		PAGEDOWN,
		RIGHT,
		LEFT,
		DOWN,
		UP,
		NUMLOCKCLEAR,
		KP_DIVIDE,
		KP_MULTIPLY,
		KP_MINUS,
		KP_PLUS,
		KP_ENTER,
		KP_1,
		KP_2,
		KP_3,
		KP_4,
		KP_5,
		KP_6,
		KP_7,
		KP_8,
		KP_9,
		KP_0,
		KP_PERIOD,
		APPLICATION,
		POWER,
		KP_EQUALS,
		F13,
		F14,
		F15,
		F16,
		F17,
		F18,
		F19,
		F20,
		F21,
		F22,
		F23,
		F24,
		EXECUTE,
		HELP,
		MENU,
		SELECT,
		STOP,
		AGAIN,
		UNDO,
		CUT,
		COPY,
		PASTE,
		FIND,
		MUTE,
		VOLUMEUP,
		VOLUMEDOWN,
		KP_COMMA,
		KP_EQUALSAS400,
		ALTERASE,
		SYSREQ,
		CANCEL,
		CLEAR,
		PRIOR,
		RETURN2,
		SEPARATOR,
		OUT,
		OPER,
		CLEARAGAIN,
		CRSEL,
		EXSEL,
		KP_00,
		KP_000,
		THOUSANDSSEPARATOR,
		DECIMALSEPARATOR,
		CURRENCYUNIT,
		CURRENCYSUBUNIT,
		KP_LEFTPAREN,
		KP_RIGHTPAREN,
		KP_LEFTBRACE,
		KP_RIGHTBRACE,
		KP_TAB,
		KP_BACKSPACE,
		KP_A,
		KP_B,
		KP_C,
		KP_D,
		KP_E,
		KP_F,
		KP_XOR,
		KP_POWER,
		KP_PERCENT,
		KP_LESS,
		KP_GREATER,
		KP_AMPERSAND,
		KP_DBLAMPERSAND,
		KP_VERTICALBAR,
		KP_DBLVERTICALBAR,
		KP_COLON,
		KP_HASH,
		KP_SPACE,
		KP_AT,
		KP_EXCLAM,
		KP_MEMSTORE,
		KP_MEMRECALL,
		KP_MEMCLEAR,
		KP_MEMADD,
		KP_MEMSUBTRACT,
		KP_MEMMULTIPLY,
		KP_MEMDIVIDE,
		KP_PLUSMINUS,
		KP_CLEAR,
		KP_CLEARENTRY,
		KP_BINARY,
		KP_OCTAL,
		KP_DECIMAL,
		KP_HEXADECIMAL,
		LCTRL,
		LSHIFT,
		LALT,
		LGUI,
		RCTRL,
		RSHIFT,
		RALT,
		RGUI,
		MODE,
		AUDIONEXT,
		AUDIOPREV,
		AUDIOSTOP,
		AUDIOPLAY,
		AUDIOMUTE,
		MEDIASELECT,
		WWW,
		MAIL,
		CALCULATOR,
		COMPUTER,
		AC_SEARCH,
		AC_HOME,
		AC_BACK,
		AC_FORWARD,
		AC_STOP,
		AC_REFRESH,
		AC_BOOKMARKS,
		BRIGHTNESSDOWN,
		BRIGHTNESSUP,
		DISPLAYSWITCH,
		KBDILLUMTOGGLE,
		KBDILLUMDOWN,
		KBDILLUMUP,
		EJECT,
		SLEEP;
	}

	/**
	 * The SDL keysym structure, used in key events.
	 */
	[CCode (cname="SDL_Keysym", cheader_filename="SDL2/SDL_keyboard.h", destroy_function="", has_type_id=false)]
	public struct Keysym {
		/**
		 * Hardware specific scancode.
		 */
		public Scancode scancode;

		/**
		 * SDL virtual keysym
		 */
		public Keycode sym;

		/**
		 * Current key modifiers.
		 */
		public Keymod mod;
	}

	/**
	 * Common data every event shares.
	 */
	[CCode (cname="SDL_CommonEvent", cheader_filename="SDL2/events.h", has_type_id=false)]
	public struct CommonEvent {
		public EventType type;
		public uint32 timestamp;
	}

	/**
	 * A structure that contains the "quit requested" event.
	 *
	 * As  can be seen, the SDL_QuitEvent structure serves no useful purpose.
	 * The event itself, on the other hand, is very important. If you filter out or ignore a quit event then it is
	 * impossible for the user to close the window. On the other hand, if you do accept a quit event then the
	 * application window will be closed, and screen  updates will still report success event though the application will no longer be visible.
	 *
	 * SDL.quit_requested will return non-zero if a quit event is pending.
	 */
	[CCode (cname="SDL_QuitEvent", has_type_id=false)]
	public struct QuitEvent : CommonEvent {}

	/**
	 * Keyboard button event structure
	 *
	 * It is used when an event of type SDL_KEYDOWN or SDL_KEYUP is reported.
	 *
	 * The  type  and  state  actually  report  the  same  information,  they  just  use  different  values  to  do it!
	 * A keyboard event occurs when a key is released (type=SDK_KEYUP or state=SDL_RELEASED) and when a key is pressed
	 * (type=SDL_KEYDOWN or state=SDL_PRESSED). The information on what key was pressed or released is in the keysym structure.
	 *
	 * Repeating {@link SDL.EventType.KEYDOWN} events will occur if key repeat is enabled (see SDL_EnableKeyRepeat).
	 */
	[CCode (cname="SDL_KeyboardEvent", has_type_id=false)]
	public struct KeyboardEvent : CommonEvent {
		/**
		 * The window with keyboard focus, if any.
		 */
		[CCode (cname="windowID")]
		public uint32 windowId;

		/**
		 * The state of the key.
		 */
		public EventState state;

		/**
		 * Non-zero if this is a key repeat.
		 */
		uint8 repeat;

		/**
		 * Contains key press information.
		 */
		public Keysym keysym;
	}

	[CCode (cname="SDL_Event", cheader_filename="SDL2/SDL_events.h", destroy_function="", has_type_id=false)]
	[SimpleType]
	public struct Event {
		/**
		 * Event type, shared with all events
		 */
		public EventType type;

		/**
		 * common event data
		 */
		public CommonEvent generic;

		/**
		 * Keyboard event data
		 */
		public KeyboardEvent key;

		/**
		 * Use this function to poll for currently pending events.
		 *
		 * @param e The Event to be filled with the next event from the queue.
		 *
		 * @return 1 if there are any pending events, or 0 if there are none available.
		 */
		[CCode (cname="SDL_PollEvent")]
		public static int poll(out Event e);
	}
}

