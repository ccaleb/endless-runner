package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	[SWF(width="512", height="384", frameRate="60", backgroundColor="#000000")]
	public class Main extends Sprite
	{
		private var starling :Starling;
		
		public function Main()
		{
			starling = new Starling(MainStarling, stage);
			starling.start();
		}
	}
}