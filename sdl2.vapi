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

	[CCode (cprefix="SDL_", cname="SDL_Renderer", free_function="SDL_DestroyTexture", cheader_filename="SDL2/SDL_render.h", has_type_id=false)]
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
		 * @param srcrect The Rectangle representing the rectangle to be copied, or null to copy the entire surface.
		 * @param dst The Surface that is the blit target.
		 * @param dstrect The Rectangle representing the the rectangle that is copied into.
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
		a,
		b,
		c,
		d,
		e,
		f,
		g,
		h,
		i,
		j,
		k,
		l,
		m,
		n,
		o,
		p,
		q,
		r,
		s,
		t,
		u,
		v,
		w,
		x,
		y,
		z,
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

