AssetLoader.prototype.assets = [];
AssetLoader.prototype.m_main = undefined;
AssetLoader.prototype.jsonSource = undefined;
AssetLoader.prototype.m_asset_json_file = undefined;
AssetLoader.prototype.loader    = undefined;
function AssetLoader(mastermain,jsonurl)
{
    this.m_main = mastermain;
    this.jsonSource = jsonurl;
}
AssetLoader.prototype.init = function ()
{
    this.loader = new createjs.LoadQueue();
    this.loader.on("fileload", this.handleFileLoad);
    this.loader.on("complete", this.handleComplete.context(this));
    if (this.jsonSource !== undefined)
    {
        this.loader.loadFile(this.jsonSource);
    }
    else
    {
        alert("JSON Address not filled in AssetLoader.js");
    }
};
AssetLoader.prototype.handleComplete = function (e)
{
    console.log("AssetLoader: JSON handleComplete");
    this.m_asset_json_file = e.currentTarget._loadedResults[this.jsonSource].assets[0];
    this.m_main.checkLoadedFiles();
};
AssetLoader.prototype.handleFileLoad = function (e)
{
    //console.log("AssetLoader: JSON handleFileLoad");
};