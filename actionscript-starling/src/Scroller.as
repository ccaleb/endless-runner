package
{
	import starling.display.Sprite;

	public final class Scroller
	{
		private var far :Far;
		private var mid :Mid;
		private var viewportX :Number;
		
		public function Scroller(parent :Sprite)
		{
			far = new Far();
			parent.addChild(far);
			
			mid = new Mid();
			parent.addChild(mid);
			
			viewportX = 0;
		}
		
		public function setViewportX(viewportX :Number) :void
		{
			this.viewportX = viewportX;
			far.setViewportX(viewportX);
			mid.setViewportX(viewportX);
		}
		
		public function getViewportX() :Number
		{
			return viewportX;
		}
		
		public function moveViewportXBy(units :Number) :void
		{
			var newViewportX :Number = viewportX + units;
			setViewportX(newViewportX);
		}
	}
}