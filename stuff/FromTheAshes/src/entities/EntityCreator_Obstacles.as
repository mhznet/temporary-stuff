package entities
{
	import ash.core.Engine;
	
	import starling.textures.TextureAtlas;

	public class EntityCreator_Obstacles
	{
		private var engine:Engine;
		private var atlas:TextureAtlas;
		
		public function EntityCreator_Obstacles(ashEngine:Engine, atlasValue:TextureAtlas)
		{
			engine = ashEngine;
			atlas = atlasValue;
		}
		public function destroy():void{}
	}
}