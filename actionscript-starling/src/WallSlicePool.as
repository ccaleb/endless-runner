package
{
	import starling.display.Image;
	import starling.textures.TextureAtlas;

	public final class WallSlicePool
	{
		private var textureAtlas :TextureAtlas;
		private var windows :Vector.<Image>;
		private var decorations :Vector.<Image>;
		private var frontEdges :Vector.<Image>;
		private var backEdges :Vector.<Image>;
		private var steps :Vector.<Image>;
		
		public function WallSlicePool(textureAtlas :TextureAtlas)
		{
			this.textureAtlas = textureAtlas;
			createWindows();
			createDecorations();
			createFrontEdges();
			createBackEdges();
			createSteps();
		}
		
		public function borrowWindow() :Image
		{
			return windows.shift();
		}
		
		public function returnWindow(image :Image) :void
		{
			windows.push(image);
		}
		
		public function borrowDecoration() :Image
		{
			return decorations.shift();
		}
		
		public function returnDecoration(image :Image) :void
		{
			decorations.push(image);
		}
		
		public function borrowFrontEdge() :Image
		{
			return frontEdges.shift();
		}
		
		public function returnFrontEdge(image :Image) :void
		{
			frontEdges.push(image);
		}
		
		public function borrowBackEdge() :Image
		{
			return backEdges.shift();
		}
		
		public function returnBackEdge(image :Image) :void
		{
			backEdges.push(image);
		}
		
		public function borrowStep() :Image
		{
			return steps.shift();
		}
		
		public function returnStep(image :Image) :void
		{
			steps.push(image);
		}
		
		private function createWindows() :void
		{
			windows = new Vector.<Image>();
			
			addWindowImages(6, "window_01");
			addWindowImages(6, "window_02");
			
			shuffle(windows);
		}
		
		private function createDecorations() :void
		{
			decorations = new Vector.<Image>();
			
			addDecorationImages(6, "decoration_01");
			addDecorationImages(6, "decoration_02");
			addDecorationImages(6, "decoration_03");
			
			shuffle(decorations);
		}
		
		private function createFrontEdges() :void
		{
			frontEdges = new Vector.<Image>();
			
			addFrontEdgeImages(2, "edge_01");
			addFrontEdgeImages(2, "edge_02");
			
			shuffle(frontEdges);
		}
		
		private function createBackEdges() :void
		{
			backEdges = new Vector.<Image>();
			
			addBackEdgeImages(2, "edge_01");
			addBackEdgeImages(2, "edge_02");
			
			shuffle(backEdges);
		}
		
		private function createSteps() :void
		{
			steps = new Vector.<Image>();
			addStepImages(2, "step_01");
		}
		
		private function addWindowImages(amount :int, frameId :String) :void
		{
			for (var i :int = 0; i < amount; i++)
			{
				var image :Image = new Image(textureAtlas.getTexture(frameId));
				windows.push(image);
			}
		}
		
		private function addDecorationImages(amount :int, frameId :String) :void
		{
			for (var i :int = 0; i < amount; i++)
			{
				var image :Image = new Image(textureAtlas.getTexture(frameId));
				decorations.push(image);
			}
		}
		
		private function addFrontEdgeImages(amount :int, frameId :String) :void
		{
			for (var i :int = 0; i < amount; i++)
			{
				var image :Image = new Image(textureAtlas.getTexture(frameId));
				frontEdges.push(image);
			}
		}
		
		private function addBackEdgeImages(amount :int, frameId :String) :void
		{
			for (var i :int = 0; i < amount; i++)
			{
				var image :Image = new Image(textureAtlas.getTexture(frameId));
				image.pivotX = image.width;
				image.scaleX = -1;
				backEdges.push(image);
			}
		}
		
		private function addStepImages(amount :int, frameId :String) :void
		{
			for (var i :int = 0; i < amount; i++)
			{
				var image :Image = new Image(textureAtlas.getTexture(frameId));
				image.pivotY = image.height * 0.25;
				steps.push(image);
			}
		}
		
		private function shuffle(vector :Vector.<Image>) :void
		{
			var len :int = vector.length;
			var shuffles :Number = len * 3;
			for (var i :int = 0; i < shuffles; i++)
			{
				var wallSlice :Image = vector.pop();
				var pos :Number = Math.floor(Math.random() * (len-1));
				vector.splice(pos, 0, wallSlice);
			}
		}
	}
}