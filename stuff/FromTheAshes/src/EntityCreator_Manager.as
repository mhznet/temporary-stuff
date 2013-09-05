package
{
	import ash.core.Engine;
	
	import entities.EntityCreator_BackGround;
	import entities.EntityCreator_NPCs;
	import entities.EntityCreator_Obstacles;
	import entities.EntityCreator_Player;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EntityCreator_Manager
	{
		[Embed(source="assets/character_atlas.xml", mimeType="application/octet-stream")]
		public const Game_Atlas_XML:Class;
		[Embed(source="assets/asset_atlas.png")]
		public const Game_Atlas_PNG:Class;
		private var ashEngine			:Engine;
		private var atlas 				:TextureAtlas;
		private var playerCreator		:EntityCreator_Player;
		private var obstaclesCreator	:EntityCreator_Obstacles;
		private var backGroundCreator	:EntityCreator_BackGround;
		private var npcCreator			:EntityCreator_NPCs;
		public function EntityCreator_Manager(engine:Engine)
		{
			ashEngine = engine;
			createAtlas();
			createAshEntities();
		}
		private function createAtlas():void
		{
			var texture:Texture = Texture.fromBitmap(new Game_Atlas_PNG());
			var xml:XML = XML(new Game_Atlas_XML());
			atlas = new TextureAtlas(texture, xml);
		}
		private function createAshEntities():void
		{
			createBackGround();
			createPlayer();
			createNPCs();
			createObstacles();
		}
		private function createBackGround():void
		{
			backGroundCreator = new EntityCreator_BackGround(ashEngine, atlas);
		}
		private function createPlayer():void
		{
			playerCreator = new EntityCreator_Player(ashEngine, atlas);
		}
		private function createNPCs():void
		{
			npcCreator = new EntityCreator_NPCs(ashEngine, atlas);
		}
		private function createObstacles():void
		{
			obstaclesCreator = new EntityCreator_Obstacles(ashEngine, atlas);
		}
		public function destroy():void
		{
			if (obstaclesCreator) obstaclesCreator.destroy();
			if (npcCreator) npcCreator.destroy();
			if (playerCreator) playerCreator.destroy();
			if (backGroundCreator) backGroundCreator.destroy();
		}
	}
}