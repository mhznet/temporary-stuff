using UnityEngine;
using System.Collections;

public class PauseButton : MonoBehaviour 
{
    public void OnClickPause()
    {
        Debug.Log("OnClickPause");
        Application.LoadLevel("sceneName");
    }
}
