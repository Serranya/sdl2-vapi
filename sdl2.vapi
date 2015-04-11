[CCode (cprefix="SDL_", cheader_filename="SDL2/SDL.h")]
namespace SDL {

	/**
	 * These flags can be OR'd together.
	 */
	[Flags, CCode (cname="int", cprefix="SDL_INIT_", has_type_id=false)]
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
		 * compatibility; this flag is ignored
		 */
		NOPARACHUTE
	}

	/**
	 * Use this function to initialize the SDL library. This must be called before using any other SDL function.
	 *
	 * The Event Handling, File I/O, and Threading subsystems are initialized by default.
	 * You must specifically initialize other subsystems if you use them in your application.
	 *
	 * If you want to initialize subsystems separately you would call SDL.init(0) followed by
	 * SDL.init_sub_system() with the desired subsystem flag.
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
	 * SDL.init() initializes assertions and crash protection and then calls SDL.init_sub_system().
	 * If you want to bypass those protections you can call SDL_InitSubSystem() directly.
	 *
	 * Subsystem initialization is ref-counted, you must call SDL.quit_sub_system() for each SDL.init_sub_system()
	 * to correctly shutdown a subsystem manually (or call SDL.quit() to force shutdown).
	 * If a subsystem is already loaded then this call will increase the ref-count and return.
	 *
	 * @param flags any of the flags used by SDL.init().
	 *
	 * @return Returns 0 on success or a negative error code on failure; call SDL.get_error() for more information.
	 */
	[CCode (cname="SDL_InitSubSystem")]
	public static int init_sub_system(uint32 flags);

	/**
	 * Use this function to clean up all initialized subsystems. You should call it upon all exit conditions.
	 *
	 * You should call this function even if you have already shutdown each initialized subsystem with SDL.quit_sub_system().
	 * It is safe to call this function even in the case of errors in initialization.
	 *
	 * If you start a subsystem using a call to that subsystem's init function (for example SDL.Video.init())
	 * instead of SDL.init() or SDL.init_sub_system(), then you must use that subsystem's quit function (SDL.Video.quit())
	 * to shut it down before calling SDL.quit().
	 */
	[CCode (cname="SDL_Quit")]
	public static void quit();

	/**
	 * Use this function to shut down specific SDL subsystems.
	 *
	 * @param flags any of the flags used by SDL.init().
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
	 * @param flags any of the flags used by @link SDL.init().
	 *
	 * @return If flags is 0 it returns a mask of all initialized subsystems, otherwise it returns the initialization status of the specified subsystems.<<BR>>
	 * The return value does not include SDL.InitFlag.NOPARACHUTE.
	 */
	[CCode (cname="SDL_WasInit")]
	public static uint32 was_init(uint32 flags);

	/**
	 * These define alpha as the opacity of a surface.
	 */
	[CCode (cprefix="SDL_ALPHA_", cheader_filename="SDL2/SDL_pixels.h", has_type_id=false)]
	public enum Alpha {
		OPAQUE,
		TRANSPARENT
	}

	[Compact, CCode (cprefix="SDL_", cname="SDL_Window", destroy_function="SDL_DestroyWindow", cheader_filename="SDL2/SDL_video.h", has_type_id=false)]
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
		[Flags, CCode (cname="SDL_WindowFlags", cprefix="SDL_WINDOW_", has_type_id=false)]
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
		 * @param x the x position of the window, SDL.Window.POS_CENTERED or SDL.Window.POS_UNDEFINED.
		 * @param y the y position of the window, SDL.Window.POS_CENTERED or SDL.Window.POS_UNDEFINED.
		 * @param w the width of the window.
		 * @param h the height of the window.
		 * @param flags 0, or one or more of the following SDL.Window.Flags OR'd together:
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
		public static Window? create_window(string title, int x, int y, int w, int h, uint32 flags);
	}

	[Compact, CCode (cprefix="SDL_", cname="SDL_Renderer", destroy_function="SDL_DestroyTexture", cheader_filename="SDL2/SDL_render.h", has_type_id=false)]
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
		 * Note that providing no flags gives priority to available SDL_RENDERER_ACCELERATED renderers.
		 *
		 * @param window the window where rendering is displayed
		 * @param index the index of the rendering driver to initialize, or -1 to initialize the first one supporting the requested flags.
		 * @param flags 0, or one or more SDL.Renderer.Flags OR'd together.
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
		 * Use this function to update the screen with any rendering performed since the previous call.
		 */
		[CCode (cname="SDL_RenderPresent")]
		public void present();

		/**
		 * Use this function to set the color used for drawing operations (Rect, Line and Clear).
		 *
		 * @param r The Red value used to draw on the rendering target.
		 * @param g The Green value used to draw on the rendering target.
		 * @param b The Blue value used to draw on the rendering target.
		 * @param a The alpha value used to draw on the rendering target. Usually SDL.Alpha.OPAQUE (255).
		 *          Use set_draw_blend_mode() to specify how the alpha channel is used
		 *
		 * @return Returns 0 on success or a negative error code on failure; call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_SetRenderDrawColor")]
		public int set_draw_color(uint8 r, uint8 g, uint8 b, uint8 a);
	}

	[Compact, CCode (cname="SDL_TimerID", ref_function="", unref_function="", cheader_filename="SDL2/SDL_timer.h", has_type_id=false)]
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
}

