/// <reference path="d.ts/DefinitelyTyped/pixi/pixi.d.ts" />
/// <reference path="SliceType.ts" />

class WallSlice {

	public type   :SliceType;
	public y      :number;
	public sprite :PIXI.Sprite;

	public static WIDTH :number = 64;

	constructor(type :SliceType, y :number) {
		this.type   = type;
		this.y      = y;
		this.sprite = null;
	}
}