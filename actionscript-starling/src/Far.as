package
{
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public final class Far extends Image
	{
		static private var DELTA_X :Number = 0.064;
		
		[Embed(source="../resources/bg-far.png")]
		private var EmbeddedBitmap :Class;
		
		private var viewportX :Number;
		private var tempPoint :Point;
		
		public function Far()
		{
			super(Texture.fromBitmap(new EmbeddedBitmap()));
			
			x = 0;
			y = 0;
			
			texture.repeat = true;
			tempPoint = new Point(0, 0);
			
			viewportX = 0;
		}
		
		public function setViewportX(newViewportX :Number) :void
		{
			var distanceTravelled :Number = newViewportX - viewportX;
			var deltaU :Number = distanceTravelled * Far.DELTA_X;
			viewportX = newViewportX;
			
			for (var i :int = 0; i < 4; i++)
			{
				this.getTexCoords(i, tempPoint);
				tempPoint.x += deltaU;
				this.setTexCoords(i, tempPoint);
			}
		}
	}
}