using UnityEngine;
using System.Collections;

public class PlayerController : MonoBehaviour 
{
	public float speed;
	private int count;
	public GUIText countText;
	public GUIText winText;
	// Use this for initialization
	void Start () 
	{
		Debug.Log("Yay, player controller!");
		count = 0;
		winText.text = "";
		this.UpdateGUIText();
	}
	void UpdateGUIText()
	{
		this.countText.text = "Count: " + count.ToString ();
		if (count >= 4) 
		{
			winText.text = "YOU WIN!";
		}
	}
	void Update()
	{
		if (Input.GetKeyDown(KeyCode.R))
		{
			gameObject.renderer.material.color = Color.red;
		}
		if (Input.GetKeyDown(KeyCode.G))
		{
			gameObject.renderer.material.color = Color.green;
		}
		if (Input.GetKeyDown(KeyCode.B))
		{
			gameObject.renderer.material.color = Color.blue;
		}
	}
	// Update is called once per frame
	void FixedUpdate () 
	{
		float moveHor = Input.GetAxisRaw("Horizontal");
		float moveVer = Input.GetAxisRaw("Vertical");
		Vector3 movement = new Vector3 (moveHor,0.0f,moveVer);
		rigidbody.AddForce (movement * speed * Time.deltaTime);
	}
	void OnTriggerEnter(Collider other)
	{
		if (other.gameObject.tag == "PickUp") 
		{
			other.gameObject.SetActive(false);
			count++;
			this.UpdateGUIText();
		}
	}
}
