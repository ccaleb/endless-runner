/// <reference path="d.ts/DefinitelyTyped/pixi/pixi.d.ts" />
/// <reference path="Far.ts" />
/// <reference path="Mid.ts" />
/// <reference path="Walls.ts" />
/// <reference path="MapBuilder.ts" />

class Scroller {

	private mid :Mid;
	private far :Far;
	private front :Walls;
	private viewportX :number;
	private mapBuilder :MapBuilder;

	constructor(stage :PIXI.Stage) {
		this.far = new Far();
		stage.addChild(this.far);

		this.mid = new Mid();
		stage.addChild(this.mid);

		this.front = new Walls();
		stage.addChild(this.front);

		this.mapBuilder = new MapBuilder(this.front);

		this.viewportX = 0;
	}

	public setViewportX(viewportX :number) :void {
		this.viewportX = viewportX;
		this.far.setViewportX(viewportX);
		this.mid.setViewportX(viewportX);
		this.front.setViewportX(viewportX);
	}
	
	public getViewportX() :number {
		return this.viewportX;
	}

	public moveViewportXBy(units) :void {
		var newViewportX = this.viewportX + units;
		this.setViewportX(newViewportX);
	}
}