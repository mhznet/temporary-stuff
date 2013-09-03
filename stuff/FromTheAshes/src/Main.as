package
{
	import flash.display.Sprite;
	
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.tick.FrameTickProvider;
	
	import comp.DisplayComp;
	import comp.PosComp;
	import comp.SpeedComp;
	
	import systems.DisplaySystem;
	import systems.MovementSystem;

	public class Main extends Sprite
	{
		[Embed(source="assets/asset.png")]
		public var Luigi				:Class;
		private var ashEngine			:Engine;
		private var ashGraphicEntity	:Entity;
		private var tickProvider 		:FrameTickProvider;
		
		public function Main()
		{
			initialize();
		}
		private function initialize():void
		{
			createAshEngine();
			createAshEntities();
			ashEngine.addEntity(ashGraphicEntity);
			start();
		}
		private function createAshEngine():void
		{
			ashEngine = new Engine();
			ashEngine.addSystem(new MovementSystem() ,1);
			ashEngine.addSystem(new DisplaySystem(this),2);
		}
		private function createAshEntities():void
		{
			ashGraphicEntity = new Entity("LUIGI");
			ashGraphicEntity.add(new SpeedComp(10,0));
			ashGraphicEntity.add(new DisplayComp(new Luigi()));
			ashGraphicEntity.add(new PosComp(0,0));
		}
		public function start() : void
		{
			tickProvider = new FrameTickProvider( this );
			tickProvider.add(ashEngine.update);
			tickProvider.start();
		}
	}
}