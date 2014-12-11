using UnityEngine;
using System.Collections;

public class BateBallComp : MonoBehaviour {

    public bool _started = false;

    public Vector2 _speedMax;
    public Vector2 _speedMin;
    public Vector2 _speed;

    public Vector2 _position;
    public Vector2 _size;

    public float _northBorder;
    public float _southBorder;
    public float _eastBorder;
    public float _westBorder;

    public void traceStats()
    {
        float ballDeltaX = _speedMax.x; //-1;
        float ballDeltaY = _speedMax.y; // 3;

        float nextBallLeft = _westBorder + ballDeltaX;
        float nextBallRight = _eastBorder + ballDeltaX;
        float nextBallTop = _northBorder + ballDeltaY;
        float nextBallBottom = _southBorder + ballDeltaY;

        Debug.Log("Ball X/Y: " + _position + ", Width/Height: " + _size + ", Radius: " + _size.x * 0.5f);
        Debug.Log("Ball SpeedMin/Max X/Y: " + _speedMin + ", " + _speedMax);
        Debug.Log("Ball Speed X/Y: " + _speed);

        Debug.Log("Ball Right: " + nextBallRight);
        Debug.Log("Ball Left: " + nextBallLeft);
        Debug.Log("Ball Top: " + nextBallTop);
        Debug.Log("Ball Bottom: " + nextBallBottom);
    }
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}
}
