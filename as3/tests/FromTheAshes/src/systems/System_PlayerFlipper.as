package systems
{
	import ash.tools.ListIteratingSystem;
	import input.KeyPoll;
	import nodes.Node_PlayerFlipper;

	public class System_PlayerFlipper extends ListIteratingSystem
	{
		private var keyPoll:KeyPoll;
		private var flipped:Boolean = false;
		public function System_PlayerFlipper(key:KeyPoll) 
		{
			keyPoll = key;
			super(Node_PlayerFlipper, updateNode);
		}
		public function updateNode(node:Node_PlayerFlipper, time:Number):void
		{
			if (!flipped)
			{
				if (keyPoll.isDown(node.control.left) && keyPoll.isUp(node.control.right))
				{
					flipped = true;
					node.display.display.scaleX *= -1;
				}
			}
			else if (flipped)
			{
				if (keyPoll.isDown(node.control.right) && keyPoll.isUp(node.control.left))
				{
					flipped = false;
					node.display.display.scaleX *= -1;
				}
			}
		}
	}
}