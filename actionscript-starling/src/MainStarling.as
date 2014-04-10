package
{
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class MainStarling extends Sprite
	{
		[Embed(source="../resources/wall.png")]
		static private const EmbeddedSpriteSheet :Class;
		
		[Embed(source="../resources/wall.xml", mimeType="application/octet-stream")]
		static private const EmbeddedXML:Class;
		
		static private const MIN_SCROLL_SPEED    :Number = 5;
		static private const MAX_SCROLL_SPEED    :Number = 15;
		static private const SCROLL_ACCELERATION :Number = 0.005;
		
		private var textureAtlas :TextureAtlas;
		private var scroller     :Scroller;
		private var viewportX    :Number;
		private var scrollSpeed  :Number;
		
		public function MainStarling()
		{
			scrollSpeed = MainStarling.MIN_SCROLL_SPEED;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			setupSpriteSheet();
		}
		
		private function addedToStage(e :Event) :void
		{
			scroller = new Scroller(this, textureAtlas);
			addEventListener(EnterFrameEvent.ENTER_FRAME, update);
		}
		
		private function setupSpriteSheet() :void
		{
			textureAtlas = new TextureAtlas(
				Texture.fromEmbeddedAsset(EmbeddedSpriteSheet),
				XML(new EmbeddedXML())
			);
		}
		
		private function update(e :EnterFrameEvent) :void
		{
			scroller.moveViewportXBy(scrollSpeed);
			scrollSpeed += MainStarling.SCROLL_ACCELERATION;
			if (scrollSpeed > MainStarling.MAX_SCROLL_SPEED)
			{
				scrollSpeed = MainStarling.MAX_SCROLL_SPEED;
			}
		}
	}
}