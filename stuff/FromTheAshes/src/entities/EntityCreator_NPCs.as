package entities
{
	import ash.core.Engine;
	import ash.core.Entity;
	
	import comp.Comp_Display;
	import comp.Comp_NPC;
	import comp.Comp_Position;
	import comp.Comp_Speed;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class EntityCreator_NPCs
	{
		private var npcVector:Vector.<Entity>;
		private var ashEngine			:Engine;
		private var atlas 				:TextureAtlas;
		public function EntityCreator_NPCs(engine:Engine,atlasValue:TextureAtlas)
		{
			ashEngine = engine;
			atlas = atlasValue;
			//createNPCs();
		}
		private function createNPCs():void
		{
			npcVector = new Vector.<Entity>();
			for (var i:int = 1; i <= GameConstants.NPC_NUMBER; i++)
			{
				var texturVctr:Vector.<Texture> = new Vector.<Texture>();
				texturVctr.push(atlas.getTexture(GameConstants.ATLAS_WALK1));
				texturVctr.push(atlas.getTexture(GameConstants.ATLAS_WALK2));
				var mc:MovieClip = new MovieClip(texturVctr,12);
				var entity:Entity = new Entity(i.toString());
				entity.add(new Comp_Position(0,60*i));
				entity.add(new Comp_Speed(Math.ceil(Math.random()*4),0));
				entity.add(new Comp_Display(mc));
				entity.add(new Comp_NPC());
				ashEngine.addEntity(entity);
				npcVector.push(entity);
			}
		}
		public function destroy():void{}
	}
}