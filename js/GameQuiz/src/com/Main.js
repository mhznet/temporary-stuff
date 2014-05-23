var canvas;
var stag;
var sce_manager;
var loader_manager;
Function.prototype.context = function(context)
{
    var action = this;
    return function()
    {
        return action.apply(context, arguments);
    };
}
function Main ()
{
    canvas = document.getElementById("myCanv");
    stag = new createjs.Stage(canvas);
    stag.enableMouseOver();
    loader_manager = new LoaderManager(this);
}
function createScenes ()
{
    var img = loader_manager.getBMPById("img0");
    stag.addChild(img);
    stag.update();
    //sce_manager = new SceneManager(stag);
    //var m_titleScene = new TitleScene(sce_manager);
    //var m_titleScene2 = new TitleScene(sce_manager);
    //sce_manager.addScenes(m_titleScene, m_titleScene2);
    //sce_manager.nextScene();
};