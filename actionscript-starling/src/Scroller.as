package
{
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;

	public final class Scroller
	{
		private var far   :Far;
		private var mid   :Mid;
		private var front :Walls;
		
		private var mapBuilder :MapBuilder;
		
		private var viewportX :Number;
		
		public function Scroller(parent :Sprite, textureAtlas :TextureAtlas)
		{
			far = new Far();
			parent.addChild(far);
			
			mid = new Mid();
			parent.addChild(mid);
			
			front = new Walls(textureAtlas);
			parent.addChild(front);
			
			mapBuilder = new MapBuilder(front);
			
			viewportX = 0;
		}
		
		public function setViewportX(viewportX :Number) :void
		{
			this.viewportX = viewportX;
			far.setViewportX(viewportX);
			mid.setViewportX(viewportX);
			front.setViewportX(viewportX);
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