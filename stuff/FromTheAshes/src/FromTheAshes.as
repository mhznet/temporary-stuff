package
{
	import ash.core.Engine;
	import ash.integration.starling.StarlingFrameTickProvider;
	
	import entities.EntityCreator_BackGround;
	import entities.EntityCreator_NPCs;
	import entities.EntityCreator_Obstacles;
	import entities.EntityCreator_Player;
	
	import input.KeyPoll;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import systems.System_Display;
	import systems.System_NPCMovement;
	import systems.System_PlayerControl;
	import systems.System_PlayerFlipper;
	import systems.System_Priorities;
	
	public final class FromTheAshes extends Sprite
	{
		private var ashEngine			:Engine;
		private var ashEntitiesCreator	:EntityCreator_Manager;
		private var tickProvider 		:StarlingFrameTickProvider;
		private var keyPoll				:KeyPoll;
		
		public function FromTheAshes()
		{
			addEventListener(Event.ADDED_TO_STAGE, initialize);
			super();
		}
		public function initialize(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			keyPoll = new KeyPoll(Starling.current.nativeStage);
			tickProvider = new StarlingFrameTickProvider(Starling.current.juggler);
			createAshEngine();
			start();
		}
		private function createAshEngine():void
		{
			ashEngine = new Engine();
			ashEntitiesCreator = new EntityCreator_Manager(ashEngine);
			ashEngine.addSystem(new System_PlayerControl(this.keyPoll)	, System_Priorities.move);
			ashEngine.addSystem(new System_Display(this), System_Priorities.render);
			ashEngine.addSystem(new System_NPCMovement(), System_Priorities.move);
			ashEngine.addSystem(new System_PlayerFlipper(this.keyPoll), System_Priorities.move);
		}
		public function start() : void
		{
			tickProvider.add(ashEngine.update);
			tickProvider.start();
		}
	}
}