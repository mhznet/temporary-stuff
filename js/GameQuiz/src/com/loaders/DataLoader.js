DataLoader.prototype.loader    = undefined;
DataLoader.prototype.jsonSource = undefined;
DataLoader.prototype.mf_main   = undefined;
DataLoader.prototype.m_data_json_file = undefined;
function DataLoader(mainobj, jsonurl)
{
    this.mf_main = mainobj;
    this.jsonSource = jsonurl;
}
DataLoader.prototype.init = function ()
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
        alert("JSON Address not filled in DataLoader.js");
    }
};
DataLoader.prototype.handleComplete = function (e)
{
    console.log("DataLoader: JSON handleComplete");
    this.m_data_json_file = e.currentTarget._loadedResults[this.jsonSource].data[0];
    this.mf_main.checkLoadedFiles();
};
DataLoader.prototype.handleFileLoad = function (e)
{
    //console.log("DataLoader: JSON handleFileLoad");
};