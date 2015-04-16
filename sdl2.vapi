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
		 * @return Returns a new Palette class on success or NULL on failure (e.g. if there wasn't enough memory). Call SDL.get_error() for more information.
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

		public PixelFormatEnum format;

		/**
		 * An Palette structure associated with this PixelFormat, or null if the format doesn't have a palette.
		 */
		public Palette palette;

		/**
		 * the number of significant bits in a pixel value, eg: 8, 15, 16, 24, 32.
		 */
		[CCode ( cname="BitsPerPixel")]
		public uint8 bits_per_pixel;

		/**
		 * the number of bytes required to hold a pixel value, eg: 1, 2, 3, 4.
		 */
		[CCode ( cname="BytesPerPixel")]
		public uint8 bytes_per_pixel;

		/**
		 * A mask representing the location of the red component of the pixel.
		 */
		[CCode ( cname="Rmask")]
		public uint32 r_mask;

		/**
		 * A mask representing the location of the greeb component of the pixel.
		 */
		[CCode ( cname="Gmask")]
		public uint32 g_mask;

		/**
		 * A mask representing the location of the blue component of the pixel.
		 */
		[CCode ( cname="Bmask")]
		public uint32 b_mask;

		/**
		 * A mask representing the location of the alpha component of the pixel
		 * or 0 if the pixel format doesn't have any alpha information.
		 */
		[CCode ( cname="Amask")]
		public uint32 a_mask;
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
	public struct Rect {

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

	[CCode (cprefix="SDL_", cname="SDL_Window", destroy_function="SDL_DestroyWindow", cheader_filename="SDL2/SDL_video.h", has_type_id=false)]
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

		/**
		 * Use this function to get the size of a window's client area.
		 *
		 * NULL can safely be passed as the w or h parameter if the width or height value is not desired.
		 *
		 * @param w will be filled with the width of the window.
		 * @param h will be filled with the height of the window.
		 */
		[CCode (cname="SDL_GetWindowSize")]
		public void get_size(out int w, out int h);

		/**
		 * Use this function to get the SDL surface associated with the window.
		 *
		 * @return Returns the surface associated with the window, or null on failure; call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_GetWindowSurface")]
		public Surface? get_surface();
	}

	[CCode (cprefix="SDL_", cname="SDL_Renderer", destroy_function="SDL_DestroyTexture", cheader_filename="SDL2/SDL_render.h", has_type_id=false)]
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
	[CCode (cname="SDL_Surface", ref_function="SDL_Surface_ref", unref_function="SDL_FreeSurface", cheader_filename="SDL2/SDL_surface.h", has_type_id=false)]
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
		 * An Rect structure used to clip blits to the surface which can be set by set_clip_rect() (read-only)
		 */
		public Rect clip_rect;

		/**
		 * Reference count that can be incremented by the application.
		 */
		public int ref_count;

		public Surface @ref() {
			GLib.AtomicInt.inc(ref ref_count);
			return this;
		}

		/**
		 * Use this function to load a surface from a BMP file.
		 *
		 * @param file The file containing an BMP image.
		 *
		 * @return Returns a new Surface or NULL if there was an error. Call SDL.get_error() for more information.
		 */
		[CCode (cname="SDL_LoadBMP")]
		public static Surface? load_bmp(string file);
	}
}

