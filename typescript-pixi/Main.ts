/// <reference path="d.ts/DefinitelyTyped/pixi/pixi.d.ts" />
/// <reference path="WallSpritesPool.ts" />
/// <reference path="Scroller.ts" />
/// <reference path="SliceType.ts" />
/// <reference path="WallSlice.ts" />

class Main {

	private stage    :PIXI.Stage;
	private renderer :PIXI.IPixiRenderer;
	private loader   :PIXI.AssetLoader;
	private scroller :Scroller;

	private static SCROLL_SPEED :number = 5;

	constructor(canvas :HTMLCanvasElement) {
		this.stage = new PIXI.Stage(0x66FF99);
		this.renderer = PIXI.autoDetectRenderer(
			512,
			384,
			canvas
		);

		var ws :WallSlice = new WallSlice(SliceType.WINDOW, 256);

		this.loadSpriteSheet();
	}

	private update() :void {
		this.scroller.moveViewportXBy(Main.SCROLL_SPEED);
		this.renderer.render(this.stage);
		requestAnimFrame(this.update.bind(this));
	}

	private loadSpriteSheet() :void {
		var assetsToLoad :string[] = ["resources/wall.json", "resources/bg-mid.png", "resources/bg-far.png"];
		this.loader = new PIXI.AssetLoader(assetsToLoad);
		this.loader.onComplete = this.spriteSheetLoaded.bind(this);
		this.loader.load();
	}

	private spriteSheetLoaded() :void {
		this.scroller = new Scroller(this.stage);

		var pool :WallSpritesPool = new WallSpritesPool();

		requestAnimFrame(this.update.bind(this));
	}
}
