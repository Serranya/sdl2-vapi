/**
 * SDL_ttf is a TrueType font rendering library that is used with the SDL library, and almost as portable.
 * It depends on freetype2 to handle the TrueType font data. It allows a programmer to use multiple TrueType
 * fonts without having to code a font rendering routine themselves. With the power of outline fonts and antialiasing,
 * high quality text output can be obtained without much effort.
 *
 * SDL_ttf is available at [[www.libsdl.org]] or more specifically The [[http://www.libsdl.org/projects/SDL_ttf/|The SDL_ttf homepage]].
 */
[CCode (cheader_filename="SDL2/SDL_ttf.h")]
namespace SDLTTF {

	/**
	 * Initialize the truetype font API.
	 *
	 * This must be called before using other functions in this library, except {@link was_init}.
	 * SDL does not have to be initialized before this call.
	 *
	 * @return 0 on success or -1 on any error.
	 */
	[CCode (cname="TTF_Init")]
	public int init();

	/**
	 * Query the initilization status of the truetype font API.
	 * You may, of course, use this before {@link init} to avoid initializing twice in a row. Or use this to determine if you need to call {@link quit}.
	 *
	 * @return 1 if already initialized or 0 if not.
	 */
	[CCode (cname="TTF_WasInit")]
	public int was_init();

	/**
	 * Shutdown and cleanup the truetype font API.
	 * After calling this the SDL_ttf functions should not be used, excepting {@link was_init}. You may, of course, use {@link init} to use the functionality again.
	 */
	[CCode (cname="TTF_Quit")]
	public void quit();

	/**
	 * This is really a defined macro for {@link SDL.set_error}, which sets the error string which may be fetched with
	 * {@link get_error} (or {@link SDL.get_error}). This functions acts like printf, except that it is limited to SDL_ERRBUFIZE(1024) chars in length.
	 * It only accepts the following format types: %s, %d, %f, %p. No flags, precisions, field widths, nor length modifiers, are supported in the format.
	 * For any more specifics read the SDL docs.
	 */
	[CCode (cname="TTF_SetError")]
	[PrintfFormat]
	public void set_error(string fmt, ...);

	/**
	 * This is really a defined macro for {@link SDL.get_error}. It returns the last error set by {@link set_error} (or {@link SDL.set_error}) as a string.
	 * Use this to tell the user what happened when an error status has been returned from an SDL_ttf function call.
	 *
	 * @return A string containing a human readable version or the reason for the last error that occured.
	 */
	[CCode (cname="TTF_GetError")]
	public unowned string get_error();

	[CCode (cname="TTF_Font", free_function="TTF_CloseFont")]
	[Compact]
	public class Font {

		/**
		 * Load file for use as a font, at ptsize size.
		 *
		 * This is actually Font.open_index(file, ptsize, 0). This can load TTF and FON files.
		 *
		 * @param file File name to load font from.
		 * @param ptsize Point size (based on 72DPI) to load font as. This basically translates to pixel height.
		 *
		 * @return The {@link Font} or null on errors.
		 */
		[CCode (cname="TTF_OpenFont")]
		public static Font? open(string file, int ptsize);

		/**
		 * Render the LATIN1 encoded text with fg color onto a new surface, using the Solid mode.
		 *
		 * @param text The LATIN1 null terminated string to render.
		 * @param fg The color to render the text in. This becomes colormap index 1.
		 *
		 * @return A new {@link SDL.Surface}. null is returned on errors.
		 */
		[CCode (cname="TTF_RenderText_Solid")]
		public SDL.Surface? render(string text, SDL.Color fg);
	}
}
