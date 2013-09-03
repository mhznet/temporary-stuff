package
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.tick.FrameTickProvider;
	
	import comp.Comp_PlayerControl;
	import comp.Comp_FlashDisplay;
	import comp.Comp_NPC;
	import comp.Comp_Position;
	import comp.Comp_Speed;
	
	import input.KeyPoll;
	
	import systems.System_PlayerControl;
	import systems.System_FlashDisplay;
	import systems.System_NPCMovement;
	import systems.System_Priorities;
	
	public final class FromTheAshes extends Sprite
	{
		private var mainContainer		:DisplayObjectContainer;
		private var ashEngine			:Engine;
		private var ashGraphicEntity	:Entity;
		private var tickProvider 		:FrameTickProvider;
		private var keyPoll				:KeyPoll;
		[Embed(source="assets/asset.png")]
		private var Luigi:Class;
		
		public function FromTheAshes(cont:DisplayObjectContainer)
		{
			mainContainer = cont;
			super();
		}
		public function initialize():void
		{
			keyPoll = new KeyPoll(mainContainer.stage);
			tickProvider = new FrameTickProvider(mainContainer.stage);
			createAshEngine();
			createAshEntities();
			start();
		}
		private function createAshEngine():void
		{
			ashEngine = new Engine();
			ashEngine.addSystem(new System_PlayerControl(this.keyPoll)	, System_Priorities.move);
			ashEngine.addSystem(new System_FlashDisplay(this)	, System_Priorities.render);
			ashEngine.addSystem(new System_NPCMovement()	, System_Priorities.move);
		}
		private function createAshEntities():void
		{
			ashGraphicEntity = new Entity(GameConstants.LUIGI);
			ashGraphicEntity.add(new Comp_Position(0,0));
			ashGraphicEntity.add(new Comp_Speed(10,0));
			ashGraphicEntity.add(new Comp_PlayerControl(Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, Keyboard.DOWN, Keyboard.SPACE));
			ashGraphicEntity.add(new Comp_FlashDisplay(new Luigi()));
			ashEngine.addEntity(ashGraphicEntity);
			
			for (var i:int = 1; i <= GameConstants.NPC_NUMBER; i++) 
			{
				var entity:Entity = new Entity(i.toString());
				entity.add(new Comp_Position(0,60*i));
				entity.add(new Comp_Speed(Math.ceil(Math.random()*4),0));
				entity.add(new Comp_FlashDisplay(new Luigi()));
				entity.add(new Comp_NPC());
				ashEngine.addEntity(entity);
			}
		}
		public function start() : void
		{
			tickProvider.add(ashEngine.update);
			tickProvider.start();
		}
	}
}