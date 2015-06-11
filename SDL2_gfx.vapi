[CCode (cheader_filename="SDL2_gfxPrimitives.h")]
namespace SDLGraphics {

	[Compact]
	public class Circle {

		/**
		 * Draw anti-aliased circle with blending.
		 *
		 * @param renderer The renderer to draw on.
		 * @param x X coordinate of the center of the aa-circle.
		 * @param y Y coordinate of the center of the aa-circle.
		 * @param radius Radius in pixels of the aa-circle.
		 * @param color The color value of the aa-circle to draw (0xRRGGBBAA).
		 *
		 * @return Returns 0 on success, -1 on failure.
		 */
		[CCode (cname="aacircleColor")]
		public static int outline_color_aa(SDL.Renderer renderer, int16 x, int16 y, int16 radius, uint32 color);

		/**
		 * Draw filled circle with blending.
		 *
		 * @param renderer The renderer to draw on.
		 * @param x X coordinate of the center of the filled circle.
		 * @param y Y coordinate of the center of the filled circle.
		 * @param radius Radius in pixels of the filled circle.
		 * @param color The color value of the filled circle to draw (0xRRGGBBAA).
		 *
		 * @return Returns 0 on success, -1 on failure.
		 */
		[CCode (cname="filledCircleColor")]
		public static int fill_color(SDL.Renderer renderer, int16 x, int16 y, int16 radius, uint32 color);
	}
}
