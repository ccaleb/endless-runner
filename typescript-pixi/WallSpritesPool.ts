/// <reference path="d.ts/DefinitelyTyped/pixi/pixi.d.ts" />
/// <reference path="SliceType.ts" />

class WallSpritesPool {

	private windows     :PIXI.Sprite[];
	private decorations :PIXI.Sprite[];
	private frontEdges  :PIXI.Sprite[];
	private backEdges   :PIXI.Sprite[];
	private steps       :PIXI.Sprite[];

	constructor() {
		this.createWindows();
		this.createDecorations();
		this.createFrontEdges();
		this.createBackEdges();
		this.createSteps();
	}

	public borrowWindow() :PIXI.Sprite {
		return this.windows.shift();
	}

	public returnWindow(sprite :PIXI.Sprite) :void {
		this.windows.push(sprite);
	}

	public borrowDecoration() :PIXI.Sprite {
		return this.decorations.shift();
	}

	public returnDecoration(sprite :PIXI.Sprite) :void {
		this.decorations.push(sprite);
	}

	public borrowFrontEdge() :PIXI.Sprite {
		return this.frontEdges.shift();
	}

	public returnFrontEdge(sprite :PIXI.Sprite) :void {
		this.frontEdges.push(sprite);
	}

	public borrowBackEdge() :PIXI.Sprite {
		return this.backEdges.shift();
	}

	public returnBackEdge(sprite :PIXI.Sprite) :void {
		this.backEdges.push(sprite);
	}

	public borrowStep() :PIXI.Sprite {
		return this.steps.shift();
	}

	public returnStep(sprite :PIXI.Sprite) :void {
		this.steps.push(sprite);
	}

	private createWindows() :void {
		this.windows = [];

		this.addWindowSprites(6, "window_01");
		this.addWindowSprites(6, "window_02");

		this.shuffle(this.windows);
	}

	private createDecorations() :void {
		this.decorations = [];

		this.addDecorationSprites(6, "decoration_01");
		this.addDecorationSprites(6, "decoration_02");
		this.addDecorationSprites(6, "decoration_03");

		this.shuffle(this.decorations);
	}

	private createFrontEdges() :void {
		this.frontEdges = [];

		this.addFrontEdgeSprites(2, "edge_01");
		this.addFrontEdgeSprites(2, "edge_02");

		this.shuffle(this.frontEdges);
	}

	private createBackEdges() :void
	{
		this.backEdges = [];

		this.addBackEdgeSprites(2, "edge_01");
		this.addBackEdgeSprites(2, "edge_02");

		this.shuffle(this.backEdges);
	}

	private createSteps() :void
	{
		this.steps = [];
		this.addStepSprites(2, "step_01");
	}

	private addWindowSprites(amount :number, frameId :string) :void {
		for (var i :number = 0; i < amount; i++)
		{
			var sprite :PIXI.Sprite = PIXI.Sprite.fromFrame(frameId);
			this.windows.push(sprite);
		}
	}

	private addDecorationSprites(amount :number, frameId :string) :void {
		for (var i :number = 0; i < amount; i++)
		{
			var sprite :PIXI.Sprite = PIXI.Sprite.fromFrame(frameId);
			this.decorations.push(sprite);
		}
	}

	private addFrontEdgeSprites(amount :number, frameId :string) :void {
		for (var i :number = 0; i < amount; i++)
		{
			var sprite :PIXI.Sprite = PIXI.Sprite.fromFrame(frameId);
			this.frontEdges.push(sprite);
		}
	}

	private addBackEdgeSprites(amount :number, frameId: string) :void {
		for (var i :number = 0; i < amount; i++)
		{
			var sprite :PIXI.Sprite = PIXI.Sprite.fromFrame(frameId);
			sprite.anchor.x = 1;
			sprite.scale.x = -1;
			this.backEdges.push(sprite);
		}
	}

	private addStepSprites(amount :number, frameId :string) :void {
		for (var i :number = 0; i < amount; i++)
		{
			var sprite = PIXI.Sprite.fromFrame(frameId);
			sprite.anchor.y = 0.25;
			this.steps.push(sprite);
		}
	}

	private shuffle(array :PIXI.Sprite[]) :void {
		var len :number = array.length;
		var shuffles :number = len * 3;
		for (var i :number = 0; i < shuffles; i++)
		{
			var wallSlice :PIXI.Sprite = array.pop();
			var pos :number = Math.floor(Math.random() * (len-1));
			array.splice(pos, 0, wallSlice);
		}
	}
}