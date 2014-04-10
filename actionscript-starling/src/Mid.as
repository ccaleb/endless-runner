package
{
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.textures.Texture;
	
	public final class Mid extends Image
	{
		static private const DELTA_X :Number = 0.00032;
		
		[Embed(source="../resources/bg-mid.png")]
		static private const EmbeddedBitmap :Class;
		
		private var viewportX :Number;
		private var tempPoint :Point;
		
		public function Mid()
		{
			super(Texture.fromBitmap(new EmbeddedBitmap()));
			
			x = 0;
			y = 128;
			
			texture.repeat = true;
			tempPoint = new Point(0, 0);
			
			viewportX = 0;
		}
		
		public function setViewportX(newViewportX :Number) :void
		{
			var distanceTravelled :Number = newViewportX - viewportX;
			var deltaU :Number = distanceTravelled * Mid.DELTA_X;
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