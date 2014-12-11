using UnityEngine;
using System.Collections;

public class PaddleTouchManager : MonoBehaviour 
{
    public bool enableTouch;
    public float paddleSpeed = 10f;
    public bool limitToBg = false;
    public GameObject paddle;
    public GameObject background;
    private bool isDragging = false;
    
    void Start() { }
    void Update() { }
    void OnMouseUp()
    {
        Debug.Log("PaddleTouchManager.OnMouseUp");
        isDragging = false;
    }
    void OnMouseDown()
    {
        Debug.Log("PaddleTouchManager.OnMouseDown");
        isDragging = true;
    }
    void OnMouseDrag()
    {
        Debug.Log("PaddleTouchManager.OnMouseDrag: ");
        if (isDragging)
        {
            var posVec = Camera.main.ScreenToWorldPoint(Input.mousePosition);
            if (limitToBg)
            {
                if (posVec.y >= background.renderer.bounds.extents.y)
                {
                    posVec.y = background.renderer.bounds.center.y - (paddle.renderer.bounds.extents.y * 0.5f);
                }
                if (posVec.y <= -background.renderer.bounds.extents.y)
                {
                    posVec.y = background.renderer.bounds.extents.y + (paddle.renderer.bounds.extents.y * 0.5f);
                }
            }
            posVec.z = this.paddle.transform.position.z;
            posVec.x = this.paddle.transform.position.x;
            this.paddle.transform.position = Vector3.MoveTowards(this.paddle.transform.position, posVec, paddleSpeed * Time.deltaTime);
        }
    }
}
