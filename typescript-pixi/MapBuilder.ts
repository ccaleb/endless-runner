/// <reference path="SliceType.ts" />
/// <reference path="Walls.ts" />

class MapBuilder {

	private walls :Walls;

	private static WALL_HEIGHTS :number[] = [
		256, // Lowest slice
		224,
		192,
		160,
		128  // Highest slice
	];

	constructor(walls :Walls) {
		this.walls = walls;
		this.createMap();
	}

	private createMap() :void {
		this.createWallSpan(3, 9, true);
		this.createGap(1);
		this.createWallSpan(1, 30);
		this.createGap(1);
		this.createWallSpan(2, 18);
		this.createGap(1);
		this.createSteppedWallSpan(2, 5, 28);
		this.createGap(1);
		this.createWallSpan(1, 10);
		this.createGap(1);
		this.createWallSpan(2, 6); 
		this.createGap(1);
		this.createWallSpan(1, 8);
		this.createGap(1);
		this.createWallSpan(2, 6);
		this.createGap(1);
		this.createWallSpan(1, 8);
		this.createGap(1)
		this.createWallSpan(2, 7);
		this.createGap(1);
		this.createWallSpan(1, 16);
		this.createGap(1);
		this.createWallSpan(2, 6);
		this.createGap(1);
		this.createWallSpan(1, 22);
		this.createGap(2);
		this.createWallSpan(2, 14);
		this.createGap(2);
		this.createWallSpan(3, 8);
		this.createGap(2);
		this.createSteppedWallSpan(3, 5, 12);
		this.createGap(3);
		this.createWallSpan(0, 8);
		this.createGap(3);
		this.createWallSpan(1, 50);
		this.createGap(20);
	}

	private createGap(spanLength :number) :void {
		for (var i :number = 0; i < spanLength; i++)
		{
			this.walls.addSlice(SliceType.GAP);
		}
	}

	private createWallSpan(
		heightIndex :number,
		spanLength  :number,
		noFront     :boolean = false,
		noBack      :boolean = false
	) :void
	{
		if (noFront == false && spanLength > 0)
		{
			this.addWallFront(heightIndex);
			spanLength--;
		}

		var midSpanLength :number = spanLength - (noBack ? 0 : 1);
		if (midSpanLength > 0)
		{
			this.addWallMid(heightIndex, midSpanLength)
			spanLength -= midSpanLength;
		}

		if (noBack == false && spanLength > 0)
		{
			this.addWallBack(heightIndex);
		}
	}

	private createSteppedWallSpan(
		heightIndex :number,
		spanALength :number,
		spanBLength :number
	) :void
	{
		if (heightIndex < 2)
		{
			heightIndex = 2;
		}

		this.createWallSpan(heightIndex, spanALength, false, true);
		this.addWallStep(heightIndex - 2);
		this.createWallSpan(heightIndex - 2, spanBLength - 1, true, false);
	}

	private addWallFront(heightIndex :number) :void {
		var y :number = MapBuilder.WALL_HEIGHTS[heightIndex];
		this.walls.addSlice(SliceType.FRONT, y);
	}

	private addWallBack(heightIndex :number) :void {
		var y :number = MapBuilder.WALL_HEIGHTS[heightIndex];
		this.walls.addSlice(SliceType.BACK, y);
	}

	private addWallMid(heightIndex :number, spanLength :number) :void {
		var y :number = MapBuilder.WALL_HEIGHTS[heightIndex];
		for (var i :number = 0; i < spanLength; i++)
		{
			if (i % 2 == 0)
			{
				this.walls.addSlice(SliceType.WINDOW, y);
			}
			else
			{
				this.walls.addSlice(SliceType.DECORATION, y);
			}
		}
	}

	private addWallStep(heightIndex :number) :void {
		var y :number = MapBuilder.WALL_HEIGHTS[heightIndex];
		this.walls.addSlice(SliceType.STEP, y);
	}
}