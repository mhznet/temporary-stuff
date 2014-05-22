AssetFile.prototype.m_id = undefined;
AssetFile.prototype.m_bmp = undefined;
function AssetFile(){}
AssetFile.prototype.getBMP = function ()
{
    if (this.m_bmp !== undefined)
    {
        return this.m_bmp.clone();
    }
}