package
{
	import flash.display.Sprite;
	
	[SWF(width="890",height="500",frameRate="24")]
	public class Main extends Sprite
	{
		public var game		:FromTheAshes;
		public function Main()
		{
			initializeGame();
		}
		private function initializeGame():void
		{
			game = new FromTheAshes(this);
			this.addChild(game);
			game.initialize();
		}
	}
}