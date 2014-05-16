DataLoader.prototype.loader    = undefined;
DataLoader.prototype.xmlSource = undefined;
DataLoader.prototype.mf_main   = undefined;

function DataLoader(mainobj, xmlurl)
{
    this.mf_main = mainobj;
    this.xmlSource = xmlurl;
}
DataLoader.prototype.init = function ()
{
    this.loader = new createjs.LoadQueue(true);
    this.loader.on("fileload", this.handleFileLoad);
    this.loader.on("complete", this.handleComplete.context(this));
    if (this.xmlSource !== undefined)
    {
        this.loader.loadFile(this.xmlSource);
    }
    else
    {
        alert("XML Address not filled in DataLoader.js");
    }
};
DataLoader.prototype.handleComplete = function (e)
{
    console.log("DataLoader: XML handleComplete" , e.currentTarget._loadedResults.getElementsByTagName(this.xmlSource));
    var parser = new DOMParser();
    var xmlDoc = parser.parseFromString(e.rawResult,"text/xml")
    this.mf_main.onXMLComplete(xmlDoc);
};
DataLoader.prototype.handleFileLoad = function (e)
{
    console.log("DataLoader: XML handleFileLoad");
};