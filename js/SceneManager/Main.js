var canvas;
var stag;
var manager;
function Main ()
{
    canvas = document.getElementById("myCanv");
    stag = new createjs.Stage(canvas);
    manager = new SceneManager(stag);
    createScenes();
}
function createScenes()
{
    for (var i = 0; i < 5; i++)
    {
        var m_scene = new ExtendedScene();
        manager.addScenes(m_scene);
        m_scene.showDisplay();
    }
    stag.update();
}