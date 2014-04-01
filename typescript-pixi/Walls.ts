/// <reference path="d.ts/DefinitelyTyped/pixi/pixi.d.ts" />
/// <reference path="WallSpritesPool.ts" />
/// <reference path="SliceType.ts" />
/// <reference path="WallSlice.ts" />

class Walls extends PIXI.DisplayObjectContainer {

	private pool :WallSpritesPool;
	private slices :WallSlice[];
	private viewportX :number;
	private viewportSliceX :number;
	private borrowWallSpriteLookup :Function[];
	private returnWallSpriteLookup :Function[];

	private static VIEWPORT_WIDTH :number = 512;
	private static VIEWPORT_NUM_SLICES :number = Math.ceil(Walls.VIEWPORT_WIDTH/WallSlice.WIDTH) + 1;

	constructor() {
		super();
		
		this.pool = new WallSpritesPool();
		this.createLookupTables();

		this.slices = [];

		this.viewportX = 0;
		this.viewportSliceX = 0;
	}

	public setViewportX(viewportX :number) :void {
		this.viewportX = this.checkViewportXBounds(viewportX);

		var prevViewportSliceX :number = this.viewportSliceX;
		this.viewportSliceX = Math.floor(this.viewportX/WallSlice.WIDTH);

		this.removeOldSlices(prevViewportSliceX);
		this.addNewSlices();
	}

	public addSlice(sliceType :SliceType, y :number = 0) :void {
		var slice :WallSlice = new WallSlice(sliceType, y);
		this.slices.push(slice);
	}

	private checkViewportXBounds(viewportX :number) :number {
		var maxViewportX :number = (this.slices.length - Walls.VIEWPORT_NUM_SLICES) * WallSlice.WIDTH;
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

	private removeOldSlices(prevViewportSliceX :number) :void {
		var numOldSlices :number = this.viewportSliceX - prevViewportSliceX;
		if (numOldSlices > Walls.VIEWPORT_NUM_SLICES)
		{
			numOldSlices = Walls.VIEWPORT_NUM_SLICES;
		}
		
		for (var i :number = prevViewportSliceX; i < prevViewportSliceX + numOldSlices; i++)
		{
			var slice = this.slices[i];
			if (slice.sprite != null)
			{
				this.returnWallSprite(slice.type, slice.sprite);
				this.removeChild(slice.sprite);
				slice.sprite = null;
			}
		}
	}

	private addNewSlices() :void {
		var firstX :number = -(this.viewportX % WallSlice.WIDTH);
		for (var i = this.viewportSliceX, sliceIndex = 0;
			     i < this.viewportSliceX + Walls.VIEWPORT_NUM_SLICES;
			     i++, sliceIndex++)
		{
			var slice :WallSlice = this.slices[i];
			if (slice.sprite == null && slice.type != SliceType.GAP)
			{
				slice.sprite = this.borrowWallSprite(slice.type);
				slice.sprite.position.x = firstX + (sliceIndex * WallSlice.WIDTH);
				slice.sprite.position.y = slice.y;

				this.addChild(slice.sprite);
			}
			else if (slice.sprite != null)
			{
				slice.sprite.position.x = firstX + (sliceIndex * WallSlice.WIDTH);
			}
		}
	}

	private createLookupTables() :void {
		this.borrowWallSpriteLookup = [];
		this.borrowWallSpriteLookup[SliceType.FRONT] = this.pool.borrowFrontEdge;
		this.borrowWallSpriteLookup[SliceType.BACK] = this.pool.borrowBackEdge;
		this.borrowWallSpriteLookup[SliceType.STEP] = this.pool.borrowStep;
		this.borrowWallSpriteLookup[SliceType.DECORATION] = this.pool.borrowDecoration;
		this.borrowWallSpriteLookup[SliceType.WINDOW] = this.pool.borrowWindow;

		this.returnWallSpriteLookup = [];
		this.returnWallSpriteLookup[SliceType.FRONT] = this.pool.returnFrontEdge;
		this.returnWallSpriteLookup[SliceType.BACK] = this.pool.returnBackEdge;
		this.returnWallSpriteLookup[SliceType.STEP] = this.pool.returnStep;
		this.returnWallSpriteLookup[SliceType.DECORATION] = this.pool.returnDecoration;
		this.returnWallSpriteLookup[SliceType.WINDOW] = this.pool.returnWindow;
	}

	private borrowWallSprite(sliceType :SliceType) :PIXI.Sprite {
		return this.borrowWallSpriteLookup[sliceType].call(this.pool);
	}

	private returnWallSprite(sliceType :SliceType, sliceSprite :PIXI.Sprite) :void {
		this.returnWallSpriteLookup[sliceType].call(this.pool, sliceSprite);
	}
}