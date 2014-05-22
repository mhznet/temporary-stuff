var canvas;
var stag;
var sce_manager;
var dta_manager;
var mahLoader;
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
    beginLoader();
}
function beginLoader()
{
    mahLoader = new LoaderManager(this);
}
function createScenes ()
{
    sce_manager = new SceneManager(stag);
    var m_titleScene = new TitleScene(sce_manager);
    var m_titleScene2 = new TitleScene(sce_manager);
    sce_manager.addScenes(m_titleScene, m_titleScene2);
    sce_manager.nextScene();
};
function onDataJSONComplete(jsonObj)
{
    console.log("DATA JSON READY!");
    dta_manager = new QAManager(this);
    dta_manager.init(jsonObj);
    createScenes();
}
function onBothJSONLoaded()
{
    var json_data = mahLoader.m_data_json_file;
    var json_asset = mahLoader.m_asset_json_file;
    console.log("ALL LOADED");
}
function onQAReady()
{
    console.log("QA's FILES READY");
};