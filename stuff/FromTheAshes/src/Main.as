package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import starling.core.Starling;
	
	[SWF(width="890",height="500",frameRate="24",backgroundColor="#000000")]
	public class Main extends Sprite
	{
		private var m_starling 	:Starling;
		private var game		:FromTheAshes;
		public function Main()
		{
			addEventListener(Event.ENTER_FRAME, initializeGame);
		}
		private function initializeGame(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, initializeGame);
			m_starling = new Starling(FromTheAshes, stage);
			m_starling.antiAliasing = 0;
			m_starling.showStats = true;
			m_starling.start();
		}
	}
}