class Mid extends PIXI.TilingSprite {

	private viewportX :number;
	private static DELTA_X :number = 0.64;

	constructor() {
		super(
			PIXI.Texture.fromImage("resources/bg-mid.png"),
			512,
			256
		);

		this.position.x = 0;
		this.position.y = 128;
		this.tilePosition.x = 0;
		this.tilePosition.y = 0;

		this.viewportX = 0;
	}

	public setViewportX(newViewportX :number) :void {
		var distanceTravelled :number = newViewportX - this.viewportX;
		this.viewportX = newViewportX;
		this.tilePosition.x -= (distanceTravelled * Mid.DELTA_X);
	}
}