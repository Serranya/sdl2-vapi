/**
 * This is a simple library to load images of various formats as SDL surfaces.
 * This library supports ICO(Icon)/CUR(Cursor)/BMP, PNM (PPM/PGM/PBM), XPM,
 * LBM(IFF ILBM), PCX, GIF, JPEG, PNG, TGA, TIFF, and XV thumbnail formats.
 */
[CCode (cheader_filename="SDL2/SDL_image.h")]
namespace SDLImage {

	[CCode (cname="IMG_InitFlags", cprefix="IMG_INIT_")]
	public enum InitFlags {
		JPG,
		PNG,
		TIF,
		WEBP,
		[CCode (cname="IMG_INIT_JPG|IMG_INIT_PNG|IMG_INIT_TIF|IMG_INIT_WEBP")]
		ALL;
	}

	/**
	 * Initialize by loading support as indicated by the flags, or at least return success if support is already loaded.
	 * You may call this multiple times, which will actually require you to call {@link quit} just once to clean up.
	 * You may call this function with a 0 to retrieve whether support was built-in or not loaded yet.
	 *
	 * Note: to load JPG, PNG, and/or TIF images you can call this function with the right {@link InitFlags} OR'd together before you program gets busy,
	 * to prevent a later hiccup while it loads the library, and to check that you do have the support that you need before you try and use it.
	 *
	 * Note: No initialization is needed nor performed when using the {@link is_jpg}, {@link is_png}, and {@link is_tif} functions.
	 *
	 * Note: this function does not always set the error string, so do not depend on {@link get_error} being meaningful all the time.
	 *
	 * @param flags Bitwise OR'd set of image formats represented by {@link InitFlags} to support by loading a library now.
	 *
	 * @return a bitmask of all the currently initted image loaders.
	 */
	[CCode (cname="IMG_Init")]
	public static int init(int flags);

	/**
	 * This function cleans up all dynamically loaded library handles, freeing memory. If support is required again it will be initialized again,
	 * either by {@link init} or loading an image with dynamic support required. You may call this function when load functions are no longer
	 * needed for the JPG, PNG, and TIF image formats. You only need to call this function once, no matter how many times {@link init} was called.
	 */
	[CCode (cname="IMG_Quit")]
	public static void quit();

	/**
	 * This is the same as {@link SDL.get_error}, which returns the last error set
	 * as a string which you may use to tell the user what happened when an error status
	 * has been returned from an SDLIimage function call.
	 *
	 * @return A string containing a human readble version or the reason for the last error that occured.
	 */
	[CCode (cname="IMG_GetError")]
	public unowned string get_error();

	/**
	 * Load file for use as an image in a new surface. This actually calls {@link load_typed_rw}, with the file extension used as the type string.
	 * This can load all supported image files, including TGA as long as the filename ends with ".tga". It is best to call this outside of event loops,
	 * and rather keep the loaded images around until you are really done with them, as disk speed and image conversion to a surface is not that speedy.
	 *
	 * Note: If the image format loader requires initialization, it will attempt to do that the first time it is needed if you have not already called {@link init}
	 * to load support for your image format.
	 *
	 * Note: If the image format supports a transparent pixel, This library will set the colorkey for the surface. You can enable RLE acceleration on the
	 * surface afterwards by calling: SDL.Surface.set_color_key(RLEACCEL, image.format.colorKey)
	 *
	 * @param file Image file name to load a surface from.
	 *
	 * @return A new {@link SDL.Surface}. null is returned on erros, such as no support built for the image, or a file reading error.
	 */
	[CCode (cname = "IMG_Load")]
	public static SDL.Surface? load(string file);
}
