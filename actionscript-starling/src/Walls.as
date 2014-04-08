package
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.TextureAtlas;

	public final class Walls extends DisplayObjectContainer
	{
		static private const VIEWPORT_WIDTH      :int = 512;
		static private const VIEWPORT_NUM_SLICES :int = Math.ceil(Walls.VIEWPORT_WIDTH/WallSlice.WIDTH) + 1;
		
		private var pool :WallSlicePool;
		private var slices :Vector.<WallSlice>;
		private var viewportX :Number;
		private var viewportSliceX :int;
		private var borrowWallSliceLookup :Vector.<Function>;
		private var returnWallSliceLookup :Vector.<Function>;
		
		public function Walls(textureAtlas :TextureAtlas)
		{
			super();
			
			pool = new WallSlicePool(textureAtlas);
			createLookupTables();
			
			slices = new Vector.<WallSlice>();
			
			viewportX = 0;
			viewportSliceX = 0;
			
			createTestWallSpan();
		}
		
		public function setViewportX(viewportX :Number) :void
		{
			viewportX = checkViewportXBounds(viewportX);
			
			var prevViewportSliceX :int = viewportSliceX;
			viewportSliceX = Math.floor(viewportX/WallSlice.WIDTH);
			
			removeOldSlices(prevViewportSliceX);
			addNewSlices();
		}
		
		public function addSlice(sliceType :int, y :Number) :void
		{
			var slice :WallSlice = new WallSlice(sliceType, y);
			slices.push(slice);
		}
		
		private function checkViewportXBounds(viewportX :Number) :Number
		{
			var maxViewportX :Number = (slices.length - Walls.VIEWPORT_NUM_SLICES) *
									   WallSlice.WIDTH;
			if (viewportX < 0)
			{
				viewportX = 0;
			}
			else if (viewportX > maxViewportX)
			{
				viewportX = maxViewportX;
			}
			
			return viewportX;
		}
		
		private function addNewSlices() :void
		{
			var firstX :int = -(viewportX % WallSlice.WIDTH);
			for (var i :int = viewportSliceX, sliceIndex :int = 0;
				     i < viewportSliceX + Walls.VIEWPORT_NUM_SLICES;
					 i++, sliceIndex++)
			{
				var slice :WallSlice = slices[i];
				if (slice.image == null && slice.type != SliceType.GAP)
				{
					slice.image = this.borrowWallSlice(slice.type);
					
					slice.image.x = firstX + (sliceIndex * WallSlice.WIDTH);
					slice.image.y = slice.y;
					
					addChild(slice.image);
				}
				else if (slice.image != null)
				{
					slice.image.x = firstX + (sliceIndex * WallSlice.WIDTH);
				}
			}
		}
		
		private function removeOldSlices(prevViewportSliceX :Number) :void
		{
			// @todo
		}
		
		private function createLookupTables() :void
		{
			borrowWallSliceLookup = new Vector.<Function>();
			borrowWallSliceLookup[SliceType.FRONT]      = pool.borrowFrontEdge;
			borrowWallSliceLookup[SliceType.BACK]       = pool.borrowBackEdge;
			borrowWallSliceLookup[SliceType.STEP]       = pool.borrowStep;
			borrowWallSliceLookup[SliceType.DECORATION] = pool.borrowDecoration;
			borrowWallSliceLookup[SliceType.WINDOW]     = pool.borrowWindow;
			
			returnWallSliceLookup = new Vector.<Function>();
			returnWallSliceLookup[SliceType.FRONT]      = pool.returnFrontEdge;
			returnWallSliceLookup[SliceType.BACK]       = pool.returnBackEdge;
			returnWallSliceLookup[SliceType.STEP]       = pool.returnStep;
			returnWallSliceLookup[SliceType.DECORATION] = pool.returnDecoration;
			returnWallSliceLookup[SliceType.WINDOW]     = pool.returnWindow;
		}
		
		private function borrowWallSlice(sliceType :int) :Image
		{
			return borrowWallSliceLookup[sliceType].call(pool);
		}
		
		private function returnWallSlice(sliceType :int, sliceImage :Image) :void
		{
			returnWallSliceLookup[sliceType].call(pool, sliceImage);
		}
		
		private function createTestWallSpan() :void
		{
			addSlice(SliceType.FRONT, 192);
			addSlice(SliceType.WINDOW, 192);
			addSlice(SliceType.DECORATION, 192);
			addSlice(SliceType.WINDOW, 192);
			addSlice(SliceType.DECORATION, 192);
			addSlice(SliceType.WINDOW, 192);
			addSlice(SliceType.DECORATION, 192);
			addSlice(SliceType.WINDOW, 192);
			addSlice(SliceType.BACK, 192);
		}
	}
}