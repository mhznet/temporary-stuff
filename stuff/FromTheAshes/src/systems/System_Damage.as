package systems
{
	import ash.tools.ListIteratingSystem;
	
	import nodes.Node_Damage;
	
	public class System_Damage extends ListIteratingSystem
	{
		public function System_Damage()
		{
			super(Node_Damage, updateNode);
		}
		private function updateNode(node:Node_Damage, timer:Number):void
		{
			//if hitou, diminui vida, se nao tem mais vida, destroy a entidade
			node.entity
			node.position
			node.doesDamage
			node.health
		}
	}
}