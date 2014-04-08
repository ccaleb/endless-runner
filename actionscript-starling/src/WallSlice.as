package
{
	import starling.display.Image;

	public final class WallSlice
	{
		static public const WIDTH :Number = 64;
		
		public var type  :int;
		public var y     :Number;
		public var image :Image;
		
		public function WallSlice(type :int, y :Number)
		{
			this.type  = type;
			this.y     = y;
			this.image = null;
		}
	}
}