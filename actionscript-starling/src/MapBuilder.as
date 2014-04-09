package
{
	public final class MapBuilder
	{
		static private const WALL_HEIGHTS :Vector.<int> = new <int>[
			256, // Lowest slice
			224,
			192,
			160,
			128  // Highest slice
		];
		
		private var walls :Walls;
		
		public function MapBuilder(walls :Walls)
		{
			this.walls = walls;
			createMap();
		}
		
		private function createMap() :void
		{
			createWallSpan(3, 9, true);
			createGap(1);
			createWallSpan(1, 30);
			createGap(1);
			createWallSpan(2, 18);
			createGap(1);
			createSteppedWallSpan(2, 5, 28);
			createGap(1);
			createWallSpan(1, 10);
			createGap(1);
			createWallSpan(2, 6); 
			createGap(1);
			createWallSpan(1, 8);
			createGap(1);
			createWallSpan(2, 6);
			createGap(1);
			createWallSpan(1, 8);
			createGap(1)
			createWallSpan(2, 7);
			createGap(1);
			createWallSpan(1, 16);
			createGap(1);
			createWallSpan(2, 6);
			createGap(1);
			createWallSpan(1, 22);
			createGap(2);
			createWallSpan(2, 14);
			createGap(2);
			createWallSpan(3, 8);
			createGap(2);
			createSteppedWallSpan(3, 5, 12);
			createGap(3);
			createWallSpan(0, 8);
			createGap(3);
			createWallSpan(1, 50);
			createGap(20);
		}
		
		private function createGap(spanLength :int) :void
		{
			for (var i :int = 0; i < spanLength; i++)
			{
				walls.addSlice(SliceType.GAP);
			}
		}
		
		private function createWallSpan(
			heightIndex :int,
			spanLength  :int,
			noFront     :Boolean = false,
			noBack      :Boolean = false  
		) :void
		{
			if (noFront == false && spanLength > 0)
			{
				addWallFront(heightIndex);
				spanLength--;
			}
			
			var midSpanLength :int = spanLength - (noBack ? 0 : 1);
			if (midSpanLength > 0)
			{
				addWallMid(heightIndex, midSpanLength);
				spanLength -= midSpanLength;
			}
			
			if (noBack == false && spanLength > 0)
			{
				addWallBack(heightIndex);
			}
		}
		
		private function createSteppedWallSpan(
			heightIndex :int,
			spanALength :int,
			spanBLength :int
		) :void
		{
			if (heightIndex < 2)
			{
				heightIndex = 2;
			}
			
			createWallSpan(heightIndex, spanALength, false, true);
			addWallStep(heightIndex - 2);
			createWallSpan(heightIndex - 2, spanBLength - 1, true, false);
		}
		
		private function addWallFront(heightIndex :int) :void
		{
			var y :Number = MapBuilder.WALL_HEIGHTS[heightIndex];
			walls.addSlice(SliceType.FRONT, y);
		}
		
		private function addWallBack(heightIndex :int) :void
		{
			var y :Number = MapBuilder.WALL_HEIGHTS[heightIndex];
			walls.addSlice(SliceType.BACK, y);
		}
		
		private function addWallMid(heightIndex :int, spanLength :int) :void
		{
			var y :Number = MapBuilder.WALL_HEIGHTS[heightIndex];
			for (var i :int = 0; i < spanLength; i++)
			{
				if (i % 2 == 0)
				{
					walls.addSlice(SliceType.WINDOW, y);
				}
				else
				{
					walls.addSlice(SliceType.DECORATION, y);
				}
			}
		}
		
		private function addWallStep(heightIndex :int) :void
		{
			var y :Number = MapBuilder.WALL_HEIGHTS[heightIndex];
			walls.addSlice(SliceType.STEP, y);
		}
	}
}