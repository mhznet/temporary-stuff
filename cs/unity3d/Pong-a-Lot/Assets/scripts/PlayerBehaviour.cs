using UnityEngine;
using System.Collections;

public class PlayerBehaviour : MonoBehaviour 
{
	public float playerSpeed = 10.0f;

	public GameObject Player_1;
	public GameObject Player_2;

	public float p1_X = 10.0f;
	public float p2_X = 10.0f;

	public Vector2 Position_1;	
	public Vector2 Position_2;

	public KeyCode p1_moveUp = KeyCode.UpArrow;
	public KeyCode p2_moveUp = KeyCode.UpArrow;

	public KeyCode p1_moveDown = KeyCode.DownArrow;
	public KeyCode p2_moveDown = KeyCode.DownArrow;
	
	void Start () 
	{
		UpdatePosition (Player_1, Position_1);
		UpdatePosition (Player_2, Position_2);
	}

	void UpdatePosition(GameObject obj, Vector2 pos)
	{
		var newPos = obj.transform.position;
		Debug.Log(newPos +", para "+ pos);
		newPos.x = pos.x;
		newPos.y = pos.y;
		obj.rigidbody2D.velocity = newPos;
	}

	void UpdatePlayerY(GameObject player, bool noKey, bool up = false)
	{
		if (noKey)
		{
			var vel = player.rigidbody2D.velocity;
			vel.y = 0.0f;
			player.rigidbody2D.velocity = vel;
		}
		else if (up) 
		{
			var vel = player.rigidbody2D.velocity;
			vel.y = playerSpeed;
			player.rigidbody2D.velocity = vel;
		}
		else if (!up)
		{
			var vel = player.rigidbody2D.velocity;
			vel.y = playerSpeed * -1;
			player.rigidbody2D.velocity = vel;
		}
		var velX = player.rigidbody2D.velocity;
		velX.x = 0;
		player.rigidbody2D.velocity = velX;
	}

	void UpdatePlayer(GameObject player, KeyCode upCode, KeyCode downCode)
	{
		if (Input.GetKey(upCode))
		{
			UpdatePlayerY(player, false,true);
		}
		else if (Input.GetKey (downCode))
		{
			UpdatePlayerY(player, false, false);
		}
		else if (!Input.anyKey)
		{
			UpdatePlayerY(player, true,false);
		}
	}

	void Update () 
	{
		UpdatePlayer (Player_1, p1_moveUp, p1_moveDown);
		UpdatePlayer (Player_2, p2_moveUp, p2_moveDown);
	}
}