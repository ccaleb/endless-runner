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
		private var EmbeddedSpriteSheet :Class;
		
		[Embed(source="../resources/wall.xml", mimeType="application/octet-stream")]
		private const EmbeddedXML:Class;
		
		private var scroller :Scroller;
		private var viewportX :Number;
		private var textureAtlas :TextureAtlas;
		
		public function MainStarling()
		{
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
			scroller.moveViewportXBy(1);
		}
	}
}