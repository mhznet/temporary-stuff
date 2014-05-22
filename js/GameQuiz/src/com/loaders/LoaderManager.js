LoaderManager.prototype.m_data_loader = undefined;
LoaderManager.prototype.m_asset_loader = undefined;
LoaderManager.prototype.m_data_json_path = "assets/myData.json";
LoaderManager.prototype.m_data_json_file = undefined;
LoaderManager.prototype.m_asset_json_path = "assets/myAssets.json";
LoaderManager.prototype.m_asset_json_file = undefined;
LoaderManager.prototype.m_main = undefined;

function LoaderManager(mastermain)
{
    this.m_main = mastermain;
    this.beginLoaders();
}
LoaderManager.prototype.beginLoaders = function ()
{
    this.m_data_loader = new DataLoader(this, this.m_data_json_path);
    this.m_data_loader.init();
    this.m_asset_loader = new AssetLoader(this, this.m_asset_json_path);
    this.m_asset_loader.init();
};
LoaderManager.prototype.checkLoadedFiles = function ()
{
    if(this.m_data_loader.m_data_json_file !== undefined && this.m_asset_loader.m_asset_json_file !== undefined)
    {
        console.log("BOTH DATA AND ASSET JSON LOADED!");
        this.m_main.onBothJSONLoaded();
    }
    else
    {
        console.log("AINDA NAO CARREGUEI AMBOS", this.m_data_loader.m_data_json_file !== undefined, this.m_asset_loader.m_asset_json_file !== undefined);
    }
};