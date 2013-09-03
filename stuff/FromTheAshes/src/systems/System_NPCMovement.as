package systems
{
	import ash.tools.ListIteratingSystem;
	
	import comp.Comp_Position;
	import comp.Comp_Speed;
	import nodes.Node_NPCMovement;

	public class System_NPCMovement extends ListIteratingSystem
	{
		public function System_NPCMovement()
		{
			super(Node_NPCMovement, updateNode);
		}
		private function updateNode(node:Node_NPCMovement, time:Number):void
		{
			var speed	:Comp_Speed = node.speed;
			var pos		:Comp_Position = node.position;
			pos.X += speed.X;
			pos.Y += speed.Y;
		}
	}
}